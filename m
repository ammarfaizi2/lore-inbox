Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTJOQxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTJOQxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:53:32 -0400
Received: from tantale.fifi.org ([216.27.190.146]:27535 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S263624AbTJOQx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:53:26 -0400
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org,
       Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
Subject: Re: LVM Snapshots
References: <20031015174017.606c6047.Christoph.Pleger@uni-dortmund.de>
	<200310151751.23103.m.c.p@wolk-project.de>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 15 Oct 2003 09:53:10 -0700
In-Reply-To: <200310151751.23103.m.c.p@wolk-project.de>
Message-ID: <87n0c2wih5.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> writes:

> On Wednesday 15 October 2003 17:40, Christoph Pleger wrote:
> 
> Hi Christoph,
> 
> > I am using a 2.4.22 kernel from www.kernel.org together with an XFS
> > patch from SGI. I want to use LVM for creating snapshots for backups,
> > but I found out that I cannot mount the snapshots of journalling
> > filesystems (EXT3, XFS, Reiser). Only JFS snapshots can be mounted.
> > My research on internet gave the result that a kernel-patch must be used
> > to solve that problem, but I could not find such a patch for Linux
> > 2.4.22, so where can I get it?
> 
> Marcelo decided not to apply that needed patch. Here it is for you to play 
> with :) ... It'll apply with offsets to 2.4.23-pre7.

What was the reason? I cannot find this thread in the archives...

Phil.
