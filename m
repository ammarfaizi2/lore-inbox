Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUH1T2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUH1T2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUH1T2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:28:16 -0400
Received: from alias.nmd.msu.ru ([193.232.127.67]:8976 "EHLO alias.nmd.msu.ru")
	by vger.kernel.org with ESMTP id S267234AbUH1T17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:27:59 -0400
Date: Sat, 28 Aug 2004 23:27:55 +0400
From: Alexander Lyamin <flx@msu.ru>
To: flx@msu.ru, Christoph Hellwig <hch@lst.de>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re:   reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040828192755.GJ6746@alias>
Reply-To: flx@msu.ru
Mail-Followup-To: flx@msu.ru, Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <20040828105929.GB6746@alias> <20040828111233.GA11339@lst.de> <20040828120502.GE6746@alias> <20040828135655.GA13380@lst.de> <20040828192350.GI6746@alias>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828192350.GI6746@alias>
X-Operating-System: Linux 2.6.5-7.104-smp
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Aug 28, 2004 at 11:23:50PM +0400, Alexander Lyamin wrote:
> Sat, Aug 28, 2004 at 03:56:55PM +0200, Christoph Hellwig wrote:
> > > 
> > > some times, some approaches to  some problems  just would not work.
> > 
> > You still haven't even bother explaining what you want to do.  It's hard
> > to argue against vague uncertainity.
> 
>  o files as directories -  no oppinion on that.
>                             
>  o metafiles -   AFAIK it was product of Nikita Danilov just playing and fooling.
> 
> Probably solution that will satisfy you is to have "legacy (dumb?) mode" which
> is leaving all this fancy stuff out of sight.

and enabled compile time or mount option...

-- 
"the liberation loophole will make it clear.."
lex lyamin
