Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422849AbWBNWkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422849AbWBNWkf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422856AbWBNWkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:40:35 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:262 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1422849AbWBNWke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:40:34 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, davidsen@tmr.com,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr>
	<20060125144543.GY4212@suse.de>
	<Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
	<20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
	<20060125181847.b8ca4ceb.grundig@teleline.es>
	<20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de>
	<878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com>
	<20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner>
	<871wy6sy7y.fsf@hades.wkstn.nix> <43F1BE96.nailMY212M61V@burner>
From: Nix <nix@esperi.org.uk>
X-Emacs: an inspiring example of form following function... to Hell.
Date: Tue, 14 Feb 2006 22:40:18 +0000
In-Reply-To: <43F1BE96.nailMY212M61V@burner> (Joerg Schilling's message of
 "Tue, 14 Feb 2006 12:27:18 +0100")
Message-ID: <87d5hpr2ct.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Joerg Schilling wrote:
> Please send me the whitepaper that was used to define the interfaces
> and functionality of the /sys device

If you seriously think that development of *anything* in the free
software world happens by means of whitepapers preceding definition, or
indeed that anything major in the Unix world has ever worked that way,
you're seriously deluded.

> Please send me the other documentation (e.g. man pages) on the /sys
> device

Oh, I thought you had *access* to the kernel source. A trivial grep
under the Documentation directory would find it (hint:
Documentation/filesystems/ is a good place to start.)

If you actually wanted to *fix* your program --- if you cared more about
users than being proved right no matter what --- then you'd have been
able to determine that for yourself in seconds.

(But then we all know that's not what you're actually after.)

> Please send me a statement on how long this interface will be maintained
> inside Linux without breaking interfaces.

What a ridiculous request. If people use it, it won't be broken. If it
proves unusable due to flaws, it will change. Sheesh.

(It is not as robust as the syscall interface, but it is still subject
to some degree of change. A trivial google would have made this clear.)

You appear not to understand the difference between development
roadmapped for years in advance by a sclerotic corporation and free
software development. Or perhaps you do understand, and are just being
pointlessly contrary. (I expect the latter is true. You're not stupid.
Just nasty.)

-- 
`... follow the bouncing internment camps.' --- Peter da Silva
