Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbSK1PEP>; Thu, 28 Nov 2002 10:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbSK1PEP>; Thu, 28 Nov 2002 10:04:15 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1796 "EHLO
	lap.molina") by vger.kernel.org with ESMTP id <S265612AbSK1PEO>;
	Thu, 28 Nov 2002 10:04:14 -0500
Date: Thu, 28 Nov 2002 09:03:14 -0600 (CST)
From: Thomas Molina <tmolina@copper.net>
X-X-Sender: tmolina@lap.molina
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] README change
In-Reply-To: <20021128133439.GA5795@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0211280901350.1023-100000@lap.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2002, Andries Brouwer wrote:

> On Wed, Nov 27, 2002 at 06:26:05PM -0600, Thomas Molina wrote:
> 
> -   Do NOT use the /usr/src/linux area! This area has a (usually
> -   incomplete) set of kernel headers that are used by the library header
> -   files.  They should match the library, and not get messed up by
> -   whatever the kernel-du-jour happens to be.
> +   Do NOT use /usr/src/linux! This directory should contain the source
> +   and headers of the kernel gcc was compile with.  They should match 
> +   the compiler, and not get messed up by whatever the kernel-du-jour
> +   happens to be.
> 
> The original text was not bad.
> The new text is completely wrong.

Yeah, I tried a simple word replacement and went too far.  Please see my 
updated patch.  I apologize to everyone for messing up good words.

