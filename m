Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSGVPRl>; Mon, 22 Jul 2002 11:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317632AbSGVPRl>; Mon, 22 Jul 2002 11:17:41 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:63995
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317622AbSGVPRk>; Mon, 22 Jul 2002 11:17:40 -0400
Date: Mon, 22 Jul 2002 08:20:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020722152031.GB692@opus.bloom.county>
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk> <20020722102930.A14802@lst.de> <20020722102705.GB21907@lukas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020722102705.GB21907@lukas>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:27:05PM +0200, Andreas Schuldei wrote:
> * Christoph Hellwig (hch@lst.de) [020722 10:29]:
> > On Mon, Jul 22, 2002 at 01:15:10AM -0600, Val Henson wrote:
> > > Sigh.  I hate this question: "How will BitKeeper make it easier to
> > > port something between 2.4 and 2.5?"  Answer: "Bk won't help - at
> > > least not as much as it would help if 2.5 had been cloned from 2.4."
> > 
> > 2.5 _is_ cloned from 2.4..
> 
> can one make use of that somehow?

Possibly, once bitkeeper allowes ChangeSets to only depend on what they
actually need, not every previous ChangeSet in the repository.  IIRC,
this was one of the things Linus asked for, so hopefully it will happen.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
