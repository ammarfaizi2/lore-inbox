Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132494AbRCZRDN>; Mon, 26 Mar 2001 12:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132493AbRCZRDE>; Mon, 26 Mar 2001 12:03:04 -0500
Received: from mail4.one.net ([206.112.192.132]:9025 "EHLO mail4.one.net")
	by vger.kernel.org with ESMTP id <S132491AbRCZRC5>;
	Mon, 26 Mar 2001 12:02:57 -0500
Date: Mon, 26 Mar 2001 12:01:55 -0500
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: ext2 corruption in 2.4.2, scsi only system
Message-ID: <20010326120155.A31414@clifton-labs.com>
In-Reply-To: <3ABF71A1.99D041E1@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABF71A1.99D041E1@torque.net>; from dougg@torque.net on Mon, Mar 26, 2001 at 11:43:13AM -0500
From: Dale E Martin <dmartin@cliftonlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dale,
> Alan Cox has reported the following:
> 
> > 2.4.2-ac19
> > .......
> > o       Hopefully fix the buslogic corruptions          (me)
> 
> Alan's ac tree also contains a consolidated set of
> patches from Eric Youngdale for the SCSI midlevel.
> Alan's latest is ac25 and may be worth trying (ac24
> has been working fine for me).

After scanning the mailing list archives, I was under the impression that
this Buslogic issue was an AC series problem.  Is there a known problem
with Buslogic controllers in 2.4.2?  

Thanks for the info.

  Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
