Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275445AbRIZSYL>; Wed, 26 Sep 2001 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275439AbRIZSYB>; Wed, 26 Sep 2001 14:24:01 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:63577 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275444AbRIZSXq>; Wed, 26 Sep 2001 14:23:46 -0400
Date: Wed, 26 Sep 2001 14:24:11 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926142411.G8223@redhat.com>
In-Reply-To: <E15mHjL-0000t8-00@the-village.bc.nu> <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com> <200109261743.f8QHhPU08423@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109261743.f8QHhPU08423@vindaloo.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Wed, Sep 26, 2001 at 11:43:25AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 11:43:25AM -0600, Richard Gooch wrote:
> BTW: your code had horrible control-M's on each line. So the compiler
> choked (with a less-than-helpful error message). Of course, cat t.c
> showed nothing amiss. Fortunately emacs doesn't hide information.

You must be using some kind of broken MUA -- neither mutt nor pine 
resulted in anything with a trace of 0x0d in it.

		-ben
