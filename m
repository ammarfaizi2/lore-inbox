Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311664AbSDAOaS>; Mon, 1 Apr 2002 09:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311712AbSDAOaI>; Mon, 1 Apr 2002 09:30:08 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:46855 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S311664AbSDAO37>; Mon, 1 Apr 2002 09:29:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Henrique Gobbi <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org
Subject: Generic HDLC Layer
Date: Mon, 1 Apr 2002 11:30:53 -0300
X-Mailer: KMail [version 1.2]
Cc: khc@pm.waw.pl
MIME-Version: 1.0
Message-Id: <02040111305301.00893@henrique.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !!!

I am running a 2.5.7 kernel and I have seen that there is something wrong 
with the sethdlc utility provide by 

	ftp://ftp.pm.waw.pl/pub/Linux/hdlc/experimental/sethdlc.c.gz

It is causing a segmentation-fault in a command like:

	sethdlc e1 clock ext
	
and it is not configuring the interfaces with the desired parameters.

Will Halasa make the new sethdlc utility, or I will have to do it by myself ?

regards
---
Henrique Gobbi
Software Engineer
Cyclades Brasil
+55 11 50333365
