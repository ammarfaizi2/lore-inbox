Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWBNEFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWBNEFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbWBNEFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:05:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48799 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030333AbWBNEFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:05:35 -0500
Date: Mon, 13 Feb 2006 20:04:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: c-otto@gmx.de
Cc: penberg@cs.Helsinki.FI, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Kernel BUG at include/linux/gfp.h:80
Message-Id: <20060213200429.0521880d.akpm@osdl.org>
In-Reply-To: <20060213201644.GA8961@carsten-otto.halifax.rwth-aachen.de>
References: <Pine.LNX.4.58.0601201214060.13564@sbz-30.cs.Helsinki.FI>
	<20060213201644.GA8961@carsten-otto.halifax.rwth-aachen.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carsten Otto <c-otto@gmx.de> wrote:
>
> Unfortunately my PC freezes as soon as I start a 3D game (Enemy
>  Territory True Combat Elite) when I see the first few 3D ingame frames.
>  Running glxgears is fine, as is running multiple instances of VLC to
>  output several audio streams through one device.
>  Switching off the sound in ET:TCE does not help at all.

Is that new behaviour?  If so, which was the most recent kernel which
worked OK?

What sort of video card are you using?

Thanks.

