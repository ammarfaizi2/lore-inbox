Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267000AbUAXShP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267001AbUAXShP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:37:15 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:2573 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S267000AbUAXShO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:37:14 -0500
Date: Sat, 24 Jan 2004 19:37:08 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "P. Christeas" <p_christ@hol.gr>
Cc: Vojtech Pavlik <vojtech@suse.cz>, lkml <linux-kernel@vger.kernel.org>,
       omnibook@zurich.csail.mit.edu
Subject: Re: Solved: atkbd w 2.6.2rc1 : HowTo for extra (inet) keys ?
Message-ID: <20040124193708.A4005@pclin040.win.tue.nl>
References: <200401232204.27819.p_christ@hol.gr> <20040123210953.GA12647@ucw.cz> <200401240428.30493.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401240428.30493.p_christ@hol.gr>; from p_christ@hol.gr on Sat, Jan 24, 2004 at 04:28:30AM +0200
X-Spam-DCC: SINECTIS: kweetal.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 04:28:30AM +0200, P. Christeas wrote:

> Download and hack the 'console-tools' package (from sourceforge, project 
> "lct") so that 'setkeycodes' does accept keycodes >127.

It sounds as if you think that the kbd setkeycodes does not handle keycodes
above 127, but it does. No hacking required.

