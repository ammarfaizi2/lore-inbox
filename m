Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316996AbSIMFxT>; Fri, 13 Sep 2002 01:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319532AbSIMFxT>; Fri, 13 Sep 2002 01:53:19 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:36104 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316996AbSIMFxS>; Fri, 13 Sep 2002 01:53:18 -0400
Date: Fri, 13 Sep 2002 07:58:01 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Tony Gale <gale@syntax.dstl.gov.uk>
Cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: XFS?
Message-ID: <20020913055801.GK14900@louise.pinerecords.com>
References: <200209121553.g8CFrrEh003646@dstl.gov.uk> <1031846624.17349.23.camel@syntax.dstl.gov.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031846624.17349.23.camel@syntax.dstl.gov.uk>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 16 days, 22:08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >EXT2 is a very capable filesystem, and has *years* of proven 
> > > >reliability. That's why I'm not going to switch away from it for 
> > > >critical work any time soon. 
> So does XFS. It just happens to be measured in IRIX years.

Don't forget you're talking four megabytes of ported code.

By the way, just out of curiosity, would someone kindly have a go at
summarizing what's going on inside XFS that would justify its sources
being almost six times the size of reiserfs?  I have read the XFS
feature list carefully, however, I still fail to see where the great
difference is.

T.
