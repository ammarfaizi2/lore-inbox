Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281874AbRKWD23>; Thu, 22 Nov 2001 22:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281877AbRKWD2T>; Thu, 22 Nov 2001 22:28:19 -0500
Received: from mx7.sac.fedex.com ([199.81.194.38]:63758 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S281874AbRKWD2M>; Thu, 22 Nov 2001 22:28:12 -0500
Date: Fri, 23 Nov 2001 11:27:58 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Jeff Chua <jchua@fedex.com>, Andreas Dilger <adilger@turbolabs.com>,
        Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        Tyler BIRD <birdty@uvsc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <5.1.0.14.2.20011123024713.00ae31c0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.42.0111231123220.16590-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 11:28:07 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 11:28:10 AM,
	Serialize complete at 11/23/2001 11:28:10 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Anton Altaparmakov wrote:

> You mean you have 1) a single file with size 3GiB on a large VFAT partition
> or 2) the VFAT partition is 3GiB in itself?

Sorry, 3GB partition. But maximum size per file is only 2GB.

Jeff

