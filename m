Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUABAkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUABAkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:40:16 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:59630 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262009AbUABAkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:40:13 -0500
Date: Thu, 1 Jan 2004 16:39:50 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-ID: <20040102003950.GF1882@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Muli Ben-Yehuda <mulix@mulix.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031229183846.GI13481@actcom.co.il> <Pine.LNX.4.58.0312291049020.2113@home.osdl.org> <20040101235147.GC1718@actcom.co.il> <20040101160420.6a326d0a.akpm@osdl.org> <20040102001203.GD1718@actcom.co.il> <20040101162643.579af2bf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101162643.579af2bf.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 04:26:43PM -0800, Andrew Morton wrote:
> Muli Ben-Yehuda <mulix@mulix.org> wrote:
> >
> > On Thu, Jan 01, 2004 at 04:04:20PM -0800, Andrew Morton wrote:
> > 
> > > hmm, how come a whitespace cleanup patch adds nearly 200 lines which have
> > > trailing whitespace?
> > 
> > That would be either xemacs's or indent's fault. Can't be my
> > fault. No sir. Anyway, unless whitespace-mode is lying to me now, no
> > line has more than at most one character of whitespace added. If it
> > bugs you, I'll clean it up - it's a slow night tonight ;-) 
> 
> Nah, leave it as is.  I'm just having a little whine.  I added a nifty
> trailing-whitespace-detector to patch-scripts a while back and it's telling
> me that a *lot* of people use broken editors.
> 

And if their editor changed the whitespace you'd get a lot more patches with
shitespace cleanups mixed in, and they'd have to clean up thhose patches... ;)
