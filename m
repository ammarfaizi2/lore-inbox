Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281864AbRKWCgU>; Thu, 22 Nov 2001 21:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281865AbRKWCgL>; Thu, 22 Nov 2001 21:36:11 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:28173 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S281864AbRKWCgD>; Thu, 22 Nov 2001 21:36:03 -0500
Date: Fri, 23 Nov 2001 10:35:42 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Andreas Dilger <adilger@turbolabs.com>
cc: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        Tyler BIRD <birdty@uvsc.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesize limit on SMBFS
In-Reply-To: <20011122125759.K1308@lynx.no>
Message-ID: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 10:35:51 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/23/2001
 10:35:53 AM,
	Serialize complete at 11/23/2001 10:35:53 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2001, Andreas Dilger wrote:

> VFAT does have a 2GB limit, AFAIK, but I could be wrong.

Use "mkdosfs -F32" or use msdos fdisk,format to get >2GB.

I'm using 3GB for VFAT partition.

Jeff.


