Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283207AbRLDT3N>; Tue, 4 Dec 2001 14:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283349AbRLDT1g>; Tue, 4 Dec 2001 14:27:36 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:41951 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S283282AbRLDT04>; Tue, 4 Dec 2001 14:26:56 -0500
Date: Tue, 4 Dec 2001 21:26:50 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Jonathan Amery <jdamery@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT370 (KT7A-RAID) *corrupts* data - SAMSUNG SV8004H does it as well
Message-ID: <20011204212650.C12063@niksula.cs.hut.fi>
In-Reply-To: <20011201115803.B10839@viasys.com> <E16BK6h-0007ZQ-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16BK6h-0007ZQ-00@chiark.greenend.org.uk>; from jdamery@chiark.greenend.org.uk on Tue, Dec 04, 2001 at 06:15:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:15:51PM +0000, you [Jonathan Amery] claimed:
> In article <20011201115803.B10839@viasys.com> you write:
> >- how come anyone else is not seeing this corruption (Abit KT7A, nevermind 
> >  HPT370 is fairly popular)?
> 
>  I've got the KT7-RAID (note, no A) but with only one drive attached to the 
> HPT370.  I have seen no problems.  I will try your recommended md5sum test 
> next time I'm at the console to be root...

I've only ever seen the corruption when reading two disks in parallel (one at
each hpt ide channel).


-- v --

v@iki.fi
