Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314398AbSDRRD4>; Thu, 18 Apr 2002 13:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314399AbSDRRDz>; Thu, 18 Apr 2002 13:03:55 -0400
Received: from reload.namesys.com ([212.16.7.75]:1327 "HELO reload.namesys.com")
	by vger.kernel.org with SMTP id <S314398AbSDRRDy>;
	Thu, 18 Apr 2002 13:03:54 -0400
Date: Thu, 18 Apr 2002 21:04:20 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: Kent Borg <kentborg@borg.org>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Versioning File Systems?
Message-ID: <20020418170420.GE24887@reload.nmd.msu.ru>
Mail-Followup-To: Kent Borg <kentborg@borg.org>,
	Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020418110558.A16135@borg.org> <20020418082025.N2710@work.bitmover.com> <20020418172758.Q4498@marowsky-bree.de> <20020418125530.C16135@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 12:55:30PM -0400, Kent Borg wrote:
> On Thu, Apr 18, 2002 at 05:27:58PM +0200, Lars Marowsky-Bree wrote:
> 
> > That would actually be pretty interesting because it might also allow you to
> > back out editor screwups ;-)
> 
> Writing an editor to take advantage of such underlying features would
> be pretty interesting too, it could be integrated into undo/redo
> features.  
> 
> Navigating such an historical fabric turns into a really interesting
> user interface problem.

There was a paper presented at SCM8 on just such a system.  They used Emacs.

    Multi-Grain Version Control in the Historian System
    Makram Abu-Shakra and Gene L. Fisher
    California Polytechnic State University, USA

    This paper describes Historian, a version control system that supports
    comprehensive versioning and features to aid history
    navigation. Comprehensive versioning is supported through frequent and
    automated creation of versions which typically results in a large number
    of versions. To reduce user overhead in history navigation, the
    hierarchical structure present in most documents is utilized to support
    fine-grained version control. The series of document editing operations is
    also organized hierarchically and can be used for navigation as well.

-josh
