Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUHVRll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUHVRll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268050AbUHVRll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:41:41 -0400
Received: from mazurek.man.lodz.pl ([212.51.192.15]:18053 "EHLO
	mazurek.man.lodz.pl") by vger.kernel.org with ESMTP id S268045AbUHVRlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:41:39 -0400
Date: Sun, 22 Aug 2004 19:41:34 +0200 (CEST)
From: Piotr Goczal <bilbo@mazurek.man.lodz.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Promise Fast Track SX6000 i2o driver.
In-Reply-To: <1093191690.24761.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408221936270.2571@mazurek.man.lodz.pl>
References: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl> 
 <1093173914.24272.45.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0408221606520.2571@mazurek.man.lodz.pl> 
 <1093184419.24617.5.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0408221854310.2571@mazurek.man.lodz.pl>
 <1093191690.24761.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-mazurek.man.lodz.pl-MailScanner-Information: Please contact bilbo@man.lodz.pl
X-mazurek.man.lodz.pl-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Alan Cox wrote:

> Then I think that the right path is probably to integrate those drivers
> into the kernel, cleaning them up if neccessary ?

If Promise has changed their policy and went off from i2o "standard" it's 
the good idea, but unfortunatelly I'm c/c++ newbie :-(. I can offer 
you access to my test machine with SX6000 installed. I even have to two 
SX 6000 so you want you can test new and old version of firmware in the 
same time.

Regards
 
Piotr Goczal
