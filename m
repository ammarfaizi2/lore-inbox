Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285134AbRLFOAt>; Thu, 6 Dec 2001 09:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285139AbRLFOAk>; Thu, 6 Dec 2001 09:00:40 -0500
Received: from fungus.teststation.com ([212.32.186.211]:17929 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S285135AbRLFOAc>; Thu, 6 Dec 2001 09:00:32 -0500
Date: Thu, 6 Dec 2001 15:00:25 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Sebastian Roth <xsebbi@gmx.de>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: smbfs questions
In-Reply-To: <200112052011.1186@xsebbi.de>
Message-ID: <Pine.LNX.4.33.0112061454510.1274-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Sebastian Roth wrote:

> Ok, I wants to write an better documentation (text-file) for smbfs. So, can 
> you tell me, who is the smbfs-maintainer, developer, please?

Search for "SMB FILESYSTEM" in the MAINTAINERS file.

Most documentation for smbfs is packaged with samba as the smbmount/smbmnt
manpages. What sort of things would you like to put in smbfs.txt?

Some of the texts in Documentation/filesystems should IMHO be manpages of
their own (example: vfat lists all options there, why not make a manpage
like nfs(5))

/Urban

