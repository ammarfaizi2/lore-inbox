Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVGCU3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVGCU3m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 16:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVGCU3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 16:29:42 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:42675 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261395AbVGCU3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 16:29:39 -0400
Date: Sun, 3 Jul 2005 22:29:56 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-2?Q?Micha=B3?= Piotrowski <piotrowskim@trex.wsi.edu.pl>
Cc: linux-kernel@vger.kernel.org,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Paul TT <paultt@bilug.linux.it>, randy_dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, cp@absolutedigital.net
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool v.b4
Message-ID: <20050703202956.GA3534@ucw.cz>
References: <42C7FBD3.1020002@trex.wsi.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42C7FBD3.1020002@trex.wsi.edu.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 03, 2005 at 04:53:07PM +0200, Micha³ Piotrowski wrote:

> Here is our (see copyright section ;)) simple script that help to create 
> a bug report:
> http://stud.wsi.edu.pl/~piotrowskim/files/ort/beta/ort-b4.tar.bz2
> 
> Why do we do this?
> Because many people don't have time to prepare a good (with all 
> importrant pieces of information) bug report.
> 
> How does it work?
> It creates file with information about your system (software, hardware, 
> used modules etc.), add file with oops into it and in the future sends 
> it to the chosen mainterner or lkml.

Sorry to say that, but:

I definitely won't be interested in bug reports from an automated tool
like this. I don't have the time to go through the heaps of information
it collects - I need a short and to the point description of the problem
from the user. Most of the time less is more, and if something is
missing, asking is always an option.

As if bug reports filled exactly in accordance with the "Reporting Bugs"
howto from Richard Gooch weren't bad enough.

> How can you help?
> If you know something about bash scripting you can review it, add some 
> useful features and make some optimalisations. Or just send me an idea.
> 
> Changelog:
> - Cal Peake (greate thanks for big patch ;)){
>    - remove the need to run the (whole) script as root
>    - add support for Pine MUA
>    - add support for nail MUA
>    - add pager selection
>    - whitespace cleanup
>    - user interface consistency
>    - code simplification
>    - some other small things
> }
> 
> Todo before final version:
> - more e-mail clients?
> - nice ascii logo?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
