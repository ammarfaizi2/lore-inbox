Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292813AbSCIP5V>; Sat, 9 Mar 2002 10:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292811AbSCIP5K>; Sat, 9 Mar 2002 10:57:10 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:12766 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S292806AbSCIP46>; Sat, 9 Mar 2002 10:56:58 -0500
From: "Guillaume Boissiere" <boissiere@attbi.com>
To: Urban Widmark <urban@teststation.com>
Date: Sat, 9 Mar 2002 10:56:31 -0500
MIME-Version: 1.0
Subject: Re: LFS support for smbfs in 2.5, and other improvements
CC: <linux-kernel@vger.kernel.org>, Guillaume Boissiere <boissiere@attbi.com>
Message-ID: <3C89EA5F.16379.4752E3A@localhost>
In-Reply-To: <20020309005423.GB896@matchmail.com>
In-Reply-To: <Pine.LNX.4.33.0203091109140.21120-100000@cola.teststation.com>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Using the terminology from the status page I guess this could be the smbfs
> list:
> 
> Alpha		smbfs: I/O rewrite, smbiod
> Alpha		smbfs: Fcntl locking + smb oplock support
> Alpha		smbfs: smbconnect for better fstab integration
> Planning	smbfs: Readahead support (async readpage/writepage)
> Planning	smbfs: Read/Write request merging
> 
> But won't the list become very long if every little driver included all
> the planned changes? Not my problem I guess ...

Yes, I am trying to limit the status list to the big items so that it 
stays readable for people.

> Also I don't know if any of this will be ready to be merged within the 6
> month limit mentioned in one of the early announcements.

Why don't we do this, if there is anything that gets close to inclusion 
and you feel it is a big thing lots of people have been anxiously waiting
for, let me know and I'll put it in.

> Regarding the updated statuspage, it isn't the "Samba filesystem", it is
> the SMB filesystem (usually smbfs, SMBFS, SMBfs and possibly other
> variations).

Fixed, thanks.

-- Guillaume



