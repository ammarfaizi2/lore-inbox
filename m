Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286153AbRLZEAZ>; Tue, 25 Dec 2001 23:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286148AbRLZEAG>; Tue, 25 Dec 2001 23:00:06 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:63700 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S286150AbRLZD74>;
	Tue, 25 Dec 2001 22:59:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: nknight@pocketinet.com, "James Stevenson" <mistral@stev.org>,
        <linux-kernel@vger.kernel.org>, <netfilter-devel@lists.samba.org>
Subject: Re: file names ?
Date: Tue, 25 Dec 2001 19:59:25 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000701c18d82$57158ea0$0801a8c0@Stev.org> <E16IyNw-0003UO-00@phalynx> <WHITEGlOVj8P8F7xztz000005f3@white.pocketinet.com>
In-Reply-To: <WHITEGlOVj8P8F7xztz000005f3@white.pocketinet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16J5Dz-0003gr-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually there should be *no* problem at all. Just enable UMSDOS and
> the UMSDOS filesystem will take care of ensuring that the FAT
> filesystem supports the links, and the same filenames. Just don't try
> to extract the files anywhere but in Linux with UMSDOS enabled.

UMSDOS is a POSIX filesystem, FAT isn't. It's pretty simple.

-Ryan
