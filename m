Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291637AbSBNN3j>; Thu, 14 Feb 2002 08:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291640AbSBNN33>; Thu, 14 Feb 2002 08:29:29 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:44556 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S291637AbSBNN3V>; Thu, 14 Feb 2002 08:29:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Henrique Gobbi <henrique@cyclades.com>
Organization: Cyclades
To: linux-kernel@vger.kernel.org
Subject: user-space <-> kernel-space
Date: Thu, 14 Feb 2002 11:33:35 -0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02021411333501.00959@henrique.cyclades.com.br>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!!

I am trying to develop a line analyzer to my multi-serial card but I am not 
seeing a good solution to send data from the driver to the application in the 
user-space.

Inittialy, I thought in use a char device, but all my minors are beeing used 
and I don't wanna to use another major. 

I'd like to know two things:
1 - Is there any way to use more than 256 minors under a major
2 - Is there a simple way to send data from the kernel-space to the 
user-space?

Any help is very welcome
thanks in advance 
-- 
Henrique Gobbi 
Linux User: 237230
Cyclades Brasil
