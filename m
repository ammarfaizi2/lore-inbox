Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWB0UAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWB0UAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWB0UAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:00:40 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44003
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932101AbWB0UAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:00:39 -0500
Date: Mon, 27 Feb 2006 12:00:41 -0800
From: Greg KH <gregkh@suse.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, davej@redhat.com, perex@suse.cz, kay.sievers@vrfy.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227200041.GA11400@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227203520.0df1d548.diegocg@gmail.com> <20060227194941.GD9991@suse.de> <20060227205759.4a7c7c13.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227205759.4a7c7c13.diegocg@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 08:57:59PM +0100, Diego Calleja wrote:
> El Mon, 27 Feb 2006 11:49:41 -0800,
> Greg KH <gregkh@suse.de> escribi?:
> 
> 
> > An explicit example of this is the evolution that sys_futex went
> > through, even after it was made a syscall...
> 
> I see...sorry for not explaining myself: Isn't "testing" just an
> alias for "unstable"?

No, look at the different descriptions that I gave them in the README
please.  They are very different.  If you think the wording there is not
precise enough, could you suggest some other wording?

thanks,

greg k-h
