Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWAFXas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWAFXas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbWAFXas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:30:48 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:42110 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932652AbWAFXar convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:30:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JGOlxWVQVqNangFrnMJhtigcwcLzlUprFX+8OHBQTyfxfFn5nGzljwEijOwTaQ/Xln2DWIqnGWVu6akZAp93s5z8yhh94DDSi5QocY65lDTR/+RUkvycBAvpL3SRKGKC0KxoVR/KCbU9+JiNwiIJPQctwRDptP2hFdgb6kK/lR8=
Message-ID: <5bdc1c8b0601061530l3a8f4378o3b9cb96c187a6049@mail.gmail.com>
Date: Fri, 6 Jan 2006 15:30:47 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Sebastian <sebastian_ml@gmx.net>
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060106232522.GA31621@section_eight.mops.rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de>
	 <43BE24F7.6070901@triplehelix.org>
	 <20060106232522.GA31621@section_eight.mops.rwth-aachen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Sebastian <sebastian_ml@gmx.net> wrote:
> Hi all!
> On Fri, Jan 06, 2006 at 12:06:15AM -0800, Joshua Kwan wrote:
> > Hi Sebastian,
> >
> > On 01/03/2006 02:20 PM, Sebastian wrote:
> > > The second series was ripped with deprecated ide-scsi emulation and yielded the
> > > same results as EAC.
> >
> > What were you using? cdparanoia? cdda2wav? (Are there actually that many
> > other options on Linux?)
> I use cdparanoia.

Try  cdparanoia -Bvz

This will cause the rip to be extremely careful and make sure
everything is exactly right. It works well for me and was recommended
by someone I trust. I hop it works for you..

Cheers,
Mark
