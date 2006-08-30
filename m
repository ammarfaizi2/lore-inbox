Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWH3Xii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWH3Xii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWH3Xii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:38:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53253 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751183AbWH3Xig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:38:36 -0400
Date: Thu, 31 Aug 2006 01:38:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/17] BLOCK: Make it possible to disable the block layer [try #2]
Message-ID: <20060830233835.GT18276@stusta.de>
References: <20060824213334.21323.76323.stgit@warthog.cambridge.redhat.com> <10117.1156522985@warthog.cambridge.redhat.com> <15945.1156854198@warthog.cambridge.redhat.com> <20060829122501.GA7814@infradead.org> <44F44639.90103@s5r6.in-berlin.de> <44F44B8D.4010700@s5r6.in-berlin.de> <Pine.LNX.4.64.0608300311430.6761@scrub.home> <44F5DA00.8050909@s5r6.in-berlin.de> <20060830214356.GO18276@stusta.de> <Pine.LNX.4.64.0608310039440.6761@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608310039440.6761@scrub.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2006 at 12:41:02AM +0200, Roman Zippel wrote:

> Hi,

Hi Roman,

> On Wed, 30 Aug 2006, Adrian Bunk wrote:
>...
> > When doing anything kconfig related, you must always remember that the 
> > vast majority of kconfig users are not kernel hackers.
> 
> What does that mean, that only kernel hackers can read?

no. But sending users from one menu to another for first manually 
selecting this or that option is less easy for the user than the usage 
of select.

> bye, Roman

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

