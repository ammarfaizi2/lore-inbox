Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUESP1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUESP1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbUESP1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:27:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1266 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264134AbUESP1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:27:14 -0400
Date: Wed, 19 May 2004 17:27:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Message-ID: <20040519152706.GD22742@fs.tum.de>
References: <40A90D00.7000005@am.sony.com> <20040517201910.A1932@infradead.org> <40A92D15.2060006@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A92D15.2060006@am.sony.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 02:22:29PM -0700, Tim Bird wrote:
> Christoph Hellwig wrote:
> >On Mon, May 17, 2004 at 12:05:36PM -0700, Tim Bird wrote:
> >
> >>I am writing to announce the availability of the first draft of
> >>the CE Linux Forum's first specification.  This specification
> >>represents the efforts of six different technical working groups
> >>over about the last 9 months.
> >
> >
> >If you want my 2Cent:
> >
> > - stop these rather useless specifications and provide patchkits instead
> > - try to actually submit the patches upstream to get a feeling which
> >   of your 'features' are compltely hopeless, which are okay and which
> >   can better be solved in different ways.
> 
> I should point out that some of the features specified have already been
> submitted as patchsets.  Some were accepted and are in 2.6.  Some were
> rejected, and we are considering the feedback received...  (But, we're
> still hopeful that in the long run, we can make certain things
> acceptable for inclusion in the mainline tree.)
> 
> The submissions, so far, have come from member companies or individuals
> rather than from the forum itself.

A good example that this is true is section 7.9.2 of your 
"specification".

It lists under "Work in Progress":
  Kernel SHALL be configuralble with compiler size options, such as -Os.

Besides the text in the "Rationale" being obviously wrong, this is 
already implemented in kernel 2.6. But the people writing this
"specification" didn't send a patch - the trivial patch was sent by 
someone who is in no way related to your "Forum".

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

