Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268161AbTBSJ3w>; Wed, 19 Feb 2003 04:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268162AbTBSJ3v>; Wed, 19 Feb 2003 04:29:51 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:9938 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268161AbTBSJ3v> convert rfc822-to-8bit; Wed, 19 Feb 2003 04:29:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.5.62]: 1/3: Make Ethernet 1000Mbit also a seperate, complete selectable submenu
Date: Wed, 19 Feb 2003 10:39:06 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
References: <200302181350.49492.m.c.p@wolk-project.de> <3E53139B.1070102@pobox.com>
In-Reply-To: <3E53139B.1070102@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302191039.07058.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 February 2003 06:18, Jeff Garzik wrote:

Hi Jeff,

> How about saving my fingers and making it CONFIG_NET_GIGE or something
> like that?
Well, the name doesn't really matter ;) but I thought about using 
"NET_ETHERNETGBIT" because 10/100mbit has "NET_ETHERNET" ...

> Other than the long config option, I'll apply your patch, it looks good
> to me.
thanks.

ciao, Marc
