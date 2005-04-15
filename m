Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVDOQGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVDOQGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVDOQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:06:41 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:12146 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261843AbVDOQGj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:06:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZhiIHcsAE92545lLcnCAW6JqzK17PzKeqRdqcTX9hTWVDeYxNhY4RdWD3mTngotQ1UFhW1s8fLiK4PCKrjqUpZkvqGCpZ7Gym+SV6MWeHH7EwY/0RAi6LztKlq5quURkPQI57ddiEMPH7De/kWeujwj4g5sMUoFQFSIgNKKRZto=
Message-ID: <21d7e9970504150906e821374@mail.gmail.com>
Date: Sat, 16 Apr 2005 02:06:38 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Exploit in 2.6 kernels
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Lars Marowsky-Bree <lmb@suse.de>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       John M Collins <jmc@xisl.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1113577241.11155.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org>
	 <1113318034.3105.46.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca>
	 <1113577241.11155.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2005-04-13 at 14:23, Lennart Sorensen wrote:
> > On Wed, Apr 13, 2005 at 03:06:46PM +0200, Lars Marowsky-Bree wrote:
> > Graphics card companies don't realize they are hardware companies not
> > software companies and that it is hardware they make their money from?
> > Oh and they have too many lawyers?
> 
> Actually they are both. 3D performance is a combination of clever driver
> technology -and- clever hardware.

Not to disagree too much, most of those "clever" driver technologies
are dirty hacks that boost performance in the quake/doom3 type
cases... but if they ever open sourced it those hardware review sites
would be over them like a bad rash...

I still don't think they would lose out by much.. I've just being
trying to RE the ATI Mpeg2 IDCT/MC hardware, ATI know this, I know
this, they are only wasting my time and my employers money (we still
are going to buy their chips... no choice..) will they give out specs
.. no .. why? cause of lawyers.. they use MPEG2 decoders for DVD
decode and some lawyer told them this is a major secret despite the
fact that everyone knows how to decode Mpeg2 and DVDs at this stage..

same story with VIA who persist on giving out a binary only blob for
MPEG2 hardware despite the fact that it was RE'ed over two years ago..
the secret is out...

Dave.
