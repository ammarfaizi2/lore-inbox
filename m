Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270255AbTHDFNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271189AbTHDFNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:13:15 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:1408 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S270255AbTHDFNO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:13:14 -0400
Date: Sun, 3 Aug 2003 22:10:02 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2-bk3
In-Reply-To: <20030804001612.GA2032@triplehelix.org>
Message-ID: <Pine.LNX.4.53.0308032124270.198@bigred.russwhit.org>
References: <Pine.LNX.4.53.0308031641270.127@bigred.russwhit.org>
 <20030804001612.GA2032@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Aug 2003, Joshua Kwan wrote:

> On Sun, Aug 03, 2003 at 04:45:31PM -0700, Russell Whitaker wrote:
> >   modprobe: QM_MODULES: function not implemented
>
> Install module-init-tools.
Thank you.
Installed module-init-tools 0.9.13-pre2 and 2.6.0 now starting to work.
(Slackware 9.0 supplied modprobe, depmod, etc.  version 2.4.22)

> And read
> http://www.codemonkey.org.uk/post-halloween-2.5.txt,
> it would have told you this if you had read it.
Interesting read. Bookmarked it.

It also would have helped if the section "SOFTWARE REQUIREMENTS"
was moved ahead of "INSTALLING the kernel:" in file Linux-2.6.0-test2/
README.

  Russ
