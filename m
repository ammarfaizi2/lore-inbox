Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264533AbSIQTll>; Tue, 17 Sep 2002 15:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264534AbSIQTll>; Tue, 17 Sep 2002 15:41:41 -0400
Received: from pcow035o.blueyonder.co.uk ([195.188.53.121]:47121 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S264533AbSIQTlk>;
	Tue, 17 Sep 2002 15:41:40 -0400
Subject: Re: Problems accessing USB Mass Storage
From: Mark C <gen-lists@blueyonder.co.uk>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net>
References: <Pine.LNX.4.33L2.0209171119430.14033-100000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 17 Sep 2002 20:46:31 +0100
Message-Id: <1032291993.1276.12.camel@stimpy.angelnet.internal>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 19:22, Randy.Dunlap wrote:

> This is a bit like what we (JE, David Brownell, and I) saw at
> the USB plugfest in 1999.  We had a camera device that we
> couldn't mount as a filesystem, but we could dd it.
> When we did that and studied the dd-ed file, we could see a
> FAT filesystem beginning after the first <N> blocks (but more than
> 25 sectors IIRC -- more like after 50-100 KB, or maybe even more).

Sorry to sound a bit bewildered, but would be the next best thing for me
to do on this?, 
I have also been advised by Jonathan Corbet 
to use dd to copy your card to disk with an offset of 25

looking through the info and man pages for dd, I can find no mention of
offset at all, the next best thing I could find was the command option
'skip'

Sorry to sound abit overwhelmed.

Mark

-- 
---
To steal ideas from one person is plagiarism;
to steal from many is research.

