Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316233AbSEQOXl>; Fri, 17 May 2002 10:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316234AbSEQOXk>; Fri, 17 May 2002 10:23:40 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:8452 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id <S316233AbSEQOXj>; Fri, 17 May 2002 10:23:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Henrique Gobbi <henrique@cyclades.com>
Reply-To: henrique@cyclades.com
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org
Subject: Inserting a new route from the kernel-space
Date: Fri, 17 May 2002 11:25:53 -0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02051711255300.27655@henrique.cyclades.com.br>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Can anyone tell me what is the way to insert a new route to the route table 
if I already have the IP address and the device and I want all packets to 
that IP address to be sent through that specific device.

Any help is welcome
Thanks in advance
Henrique
