Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262334AbSJWBEz>; Tue, 22 Oct 2002 21:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSJWBEz>; Tue, 22 Oct 2002 21:04:55 -0400
Received: from chunk.voxel.net ([207.99.115.133]:49078 "EHLO chunk.voxel.net")
	by vger.kernel.org with ESMTP id <S262334AbSJWBEy>;
	Tue, 22 Oct 2002 21:04:54 -0400
Date: Tue, 22 Oct 2002 21:11:05 -0400
From: Andres Salomon <dilinger@mp3revolution.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.44-ac1
Message-ID: <20021023011105.GA30243@chunk.voxel.net>
References: <200210221727.g9MHR6128999@devserv.devel.redhat.com> <20021022194511.GA29525@chunk.voxel.net> <ap4kpq$2tf$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap4kpq$2tf$1@main.gmane.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux chunk 2.4.18-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

07 and 08 were my own patches; ejt released 0-6.  I believe the ones he
sent alan are the same as the ones on
<http://people.sistina.com/~thornber/patches/2.5-stable/>; not
positive, though.  

For those interested, his new stuff is in
<http://people.sistina.com/~thornber/patches/2.5-stable/>..


On Tue, Oct 22, 2002 at 06:53:36PM -0400, Nicholas Wourms wrote:
> 
> Andres Salomon wrote:
> 
> > Note that the patch <http://chunk.mp3revolution.net/lvm2/patches/09.patch>
> > is necessary for Joe's older stuff; otherwise, dm oopses (with
> > 2.5.44, anyways; have not yet tried -ac1).  If you don't merge any of
> > the newer DM stuff, please at least fix the lack of gendisk
> > initialization...
> > 
> 
> Joe's got a new set of patches on his homepage, but unfortunately they 
> aren't the same ones that Alan used.  I don't suppose you have patches 1-8 
> of the original set which I could use to back out the old code?  I was 
> palnning on doing that and then patching in the new code.
> 
> Cheers,
> Nicholas
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
It's not denial.  I'm just selective about the reality I accept.
	-- Bill Watterson
