Return-Path: <linux-kernel-owner+w=401wt.eu-S965161AbXAGUqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbXAGUqO (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbXAGUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:46:14 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37116 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965152AbXAGUqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:46:13 -0500
Date: Sun, 7 Jan 2007 21:40:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sean <seanlkml@sympatico.ca>
cc: Dave Jones <davej@redhat.com>, Alan <alan@lxorguk.ukuu.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
In-Reply-To: <20070107151514.be9430b1.seanlkml@sympatico.ca>
Message-ID: <Pine.LNX.4.61.0701072139520.4365@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
 <20070107114439.GC21613@flint.arm.linux.org.uk> <45A0F060.9090207@imap.cc>
 <1168182838.14763.24.camel@shinybook.infradead.org>
 <20070107153833.GA21133@flint.arm.linux.org.uk> <20070107182151.7cc544f3@localhost.localdomain>
 <20070107191730.GD21133@flint.arm.linux.org.uk> <20070107200553.GA15101@redhat.com>
 <20070107151514.be9430b1.seanlkml@sympatico.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Sun, 7 Jan 2007 15:05:53 -0500
>Dave Jones <davej@redhat.com> wrote:
>
>> If there's something I should be doing when I commit that I'm not,
>> I'll be happy to change my scripts.  My $LANG is set to en_US.UTF-8
>> which should DTRT to the best of my knowledge, but clearly, that isn't
>> the case.

No, LC_CTYPE defines what charset you use. (I may be wrong, though.)


	-`J'
-- 
