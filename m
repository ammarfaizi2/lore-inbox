Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136744AbREKOoh>; Fri, 11 May 2001 10:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbREKOo2>; Fri, 11 May 2001 10:44:28 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:29959
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136800AbREKOoR>; Fri, 11 May 2001 10:44:17 -0400
Date: Fri, 11 May 2001 10:43:01 -0400
From: Chris Mason <mason@suse.com>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <172380000.989592181@tiny>
In-Reply-To: <20010511013913.D31966@emma1.emma.line.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, May 11, 2001 01:39:13 AM +0200 Matthias Andree
<matthias.andree@stud.uni-dortmund.de> wrote:

> On Thu, 10 May 2001, Hans Reiser wrote:
> 
>> > Hmm... Reiserfs is incompatible with knfsd?  That might explain the
>> 
>> we have a patch on our website.
> 
> I'm always wondering why the patch hasn't been merged. Is it so
> dangerous to apply in that it might distract other pieces of the system?
> Has anyone reported increased problems after applying the patch?

It requires explicit changes to each filesystem that wants to work over
NFS, and is a somewhat large change.

-chris

