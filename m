Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUAMUZO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbUAMUZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:25:14 -0500
Received: from rei.purplehat.net ([216.234.116.164]:40123 "EHLO
	rei.purplehat.net") by vger.kernel.org with ESMTP id S265149AbUAMUZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:25:09 -0500
Subject: Re: Slow NFS performance over wireless!
From: "Joshua M. Thompson" <funaho@jurai.org>
To: hackeron@dsl.pipex.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401130155.32894.hackeron@dsl.pipex.com>
References: <Pine.LNX.4.44.0401060055570.1417-100000@poirot.grange>
	 <200401130155.32894.hackeron@dsl.pipex.com>
Content-Type: text/plain
Message-Id: <1074025508.1987.10.camel@lumiere>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 13 Jan 2004 15:25:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 20:55, Roman Gaufman wrote:
> Hey,
> 
> I have experienced extremely poor NFS performance over wireless, when I scp a 
> piece of information from server to laptop, transfer rates stay stable and 
> file transfers, when I use NFS transfer rates jump constantly, and most of 
> the time file is NOT transfering.

I've noticed a similar problem here since upgrading to 2.6. In my case
not has NFS performance gone through the floor vs 2.4.22 but so has
machine performance during the transfer. In 2.4 the machine would be a
bit sluggish but usable...under 2.6 the machine is more or less
*unusable* until the NFS transfer completes. Trying to say, open up
Evolution may take upwards of ten minutes to complete. Unfortunately due
to the extreme performance problem it's not even possible to do any
diagnostics on the machine while it's happening.


