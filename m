Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUKFSbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUKFSbu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 13:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUKFSbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 13:31:50 -0500
Received: from adsl-70-241-70-1.dsl.hstntx.swbell.net ([70.241.70.1]:12168
	"EHLO leamonde.no-ip.org") by vger.kernel.org with ESMTP
	id S261376AbUKFSbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 13:31:48 -0500
Date: Sat, 6 Nov 2004 12:31:47 -0600
From: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Console 80x50 SVGA
Message-ID: <20041106183147.GB16891@leamonde.no-ip.org>
References: <20041105224206.GA16741@leamonde.no-ip.org> <20041106071245.GA28709@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106071245.GA28709@middle.of.nowhere>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 08:12:45AM +0100, Jurriaan wrote:
> From: Camilo A. Reyes <camilo@leamonde.no-ip.org>
> Date: Fri, Nov 05, 2004 at 04:42:06PM -0600
> > Greetings,
> > 
> > Just a question about displaying the console in 80x50 lines instead of 80x30. I have enabled frame buffer but as of now its doing only 80x30.
> 
> The combination of resolution and font you use allows you to get 80x30.
> 
> Try google, or read more in /usr/src/linux/Documentation/fb/
> 
> Good luck,
> Jurriaan
> -- 
> "You so much as flutter in his direction again," growled Fisher, "and
> they'll be using what's left of you for a pipe cleaner."
> The faerie winced. "Do you think you could be a little less premenstrual
> about this, darling?"
> 	Simon R Green - Beyond the Blue Moon
> Debian (Unstable) GNU/Linux 2.6.9-mm1 2x6078 bogomips load 0.40

True, but one of the issues I have is when I choose 8x8 built in character
fonts it comes up 80x50 at the begining of the bootup process, (with a
nice penguin logo too :-D) but then as the system begins to run its services
and mounting its drives it switches back to good old 80x30. :-(
