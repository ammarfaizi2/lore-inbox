Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVAaLor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVAaLor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 06:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVAaLor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 06:44:47 -0500
Received: from fw91ext.math.uni-frankfurt.de ([141.2.42.131]:3722 "EHLO
	samson.math.uni-frankfurt.de") by vger.kernel.org with ESMTP
	id S261155AbVAaLol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 06:44:41 -0500
Date: Mon, 31 Jan 2005 12:44:39 +0100 (CET)
From: Bjoern Brill <brill@fs.math.uni-frankfurt.de>
X-X-Sender: brill@samson.math.uni-frankfurt.de
To: linux-kernel@vger.kernel.org
cc: Bjoern Brill <brill@fs.math.uni-frankfurt.de>
Subject: Re: linux 2.4.28 umount oops
In-Reply-To: <Pine.LNX.4.58.0501220024310.3368@samson.math.uni-frankfurt.de>
Message-ID: <Pine.LNX.4.58.0501311238190.28815@samson.math.uni-frankfurt.de>
References: <Pine.LNX.4.58.0501220024310.3368@samson.math.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Jan 2005, Bjoern Brill wrote:

> Hello list,
>
> my machine oopses in the umount script at shutdown once every few
> weeks (at 1-2 shutdowns / day). Two times this resulted in repairable
> errors on an EXT3 filesystem during the next bootup.
>
[...]

A few days after posting this, the box developed much stranger behaviour,
like randomly segfaulting applications. A run of memtest86 revealed that
one of the RAM sticks went bad. It was good when I put it in (I tested it
back then), but most likely the bad memory is the cause of reported
oops. Praised be mentest86.

Sorry for the noise.


Regards,

Bjoern Brill
--
Bj"orn Brill <brill@fs.math.uni-frankfurt.de>
Frankfurt am Main, Germany

