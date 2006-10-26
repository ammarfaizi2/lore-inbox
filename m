Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423568AbWJZPbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423568AbWJZPbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423571AbWJZPbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:31:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423568AbWJZPbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:31:44 -0400
Date: Thu, 26 Oct 2006 17:31:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: teunis <teunis@wintersgift.com>
Cc: linux-kernel@vger.kernel.org, art@usfltd.com,
       Jiri Slaby <jirislaby@gmail.com>, Jeff Dike <jdike@addtoit.com>,
       pavel@suse.cz, linux-pm@osdl.org
Subject: Re: 2.6.19-rc3: known unfixed regressions: confirmations
Message-ID: <20061026153142.GJ27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org> <20061024202104.GF27968@stusta.de> <453E8921.2090406@wintersgift.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453E8921.2090406@wintersgift.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 02:44:01PM -0700, teunis wrote:
> Adrian Bunk wrote:
> > This email lists some known unfixed regressions in 2.6.19-rc3 compared 
> > to 2.6.18.
> ...
> 
> I'm not directly testing -rc3 as yet...  rc2-mm2 + a few modifications
> works on the equipment I'm testing and as I can't afford more lost time
> due to faults - I'm keeping to that build for the short term.
> 
> > Subject    : shutdown problem
> > References : http://lkml.org/lkml/2006/10/22/140
> > Submitter  : art@usfltd.com
> >              teunis@wintersgift.com
> >              Jiri Slaby <jirislaby@gmail.com>
> > Status     : unknown
> 
> repaired by Jeff Dike's patch to fs/proc/array.c
>...

Can you give me a pointer to this patch?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

