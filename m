Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267916AbRGRSC4>; Wed, 18 Jul 2001 14:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbRGRSCp>; Wed, 18 Jul 2001 14:02:45 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:60681 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267914AbRGRSCf>; Wed, 18 Jul 2001 14:02:35 -0400
Date: Wed, 18 Jul 2001 19:02:37 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: LDP / KDP?
Message-ID: <20010718190237.A29251@compsoc.man.ac.uk>
In-Reply-To: <200107181636.JAA24824@altair.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107181636.JAA24824@altair.dhs.org>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2001 at 09:36:48AM -0700, Charles Samuels wrote:

> _still_, I like my format more, it seems like it'd be much easier to search,
> and I think the format is much more ideal than docbook (which I have worked
> with)
> 
> e.g., an example data file: http://derkarl.org/kerneldoc/data/init_timer.kd

but docbook is not the inline docs format. DocBook is an /output/ of the hacky perl
script. You can write another hacky perl script to output in your format if you
want.

> This documentation _is_ inline to the code (in the headers), generated via a
> perl script "kdoc".

scripts/kernel-doc

john

-- 
"Voodoo Programming:  Things programmers do that they know shouldn't work but
 they try anyway, and which sometimes actually work, such as recompiling
 everything."
	- Karl Lehenbauer
