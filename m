Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTILAXh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 20:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbTILAXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 20:23:37 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:14737 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261667AbTILAXe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 20:23:34 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 11 Sep 2003 17:18:19 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: =?iso-8859-15?q?Jo=E3o=20Seabra?= <seabra@aac.uc.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: Yet another query about sis963
In-Reply-To: <200309120050.21630.seabra@aac.uc.pt>
Message-ID: <Pine.LNX.4.56.0309111716140.1889@bigblue.dev.mdolabs.com>
References: <200309120050.21630.seabra@aac.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, [iso-8859-15] João Seabra wrote:

> Hi
>
>  Could someone enlight me about the support of this chipset in 2.4 series?
>  I've read some posts about it, dating from not long time ago and since im
> planning to buy an asus l5800c with that chipset i would like to know if
> linux is going to work in it or not.
>  I have seen other problems with sis (such as graphics not (quite) working in
> linux) and i think im going to buy other laptop that doesnt use sis....
> (toshiba maybe...)

I don't know if Alan did actually fix the thing. Here you can find the IRQ
routing patches :

http://www.xmailserver.org/linux-patches/misc.html#SiSRt

This is for X :

http://www.winischhofer.net/linuxsis630.shtml



- Davide

