Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267873AbRGVDKH>; Sat, 21 Jul 2001 23:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbRGVDJ6>; Sat, 21 Jul 2001 23:09:58 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:62984 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S267873AbRGVDJv>;
	Sat, 21 Jul 2001 23:09:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Michael S. Miles" <mmiles@alacritech.com>, linux-kernel@vger.kernel.org
Subject: Re: kgdb and/or kdb for RH7.1 
In-Reply-To: Your message of "Sun, 22 Jul 2001 11:58:15 +1000."
             <1632.995767095@ocs3.ocs-net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 22 Jul 2001 13:09:50 +1000
Message-ID: <1910.995771390@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 22 Jul 2001 11:58:15 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>On Sat, 21 Jul 2001 12:30:34 -0400, 
>"Michael S. Miles" <mmiles@alacritech.com> wrote:
>>Does anyone know if patches exist against the stock RedHat 7.1
>>kernel(2.4.2-2) to support remote kernel debugging(kgdb).  I would also be
>>interested in the same for kdb, but I'm primarily interested in kgdb.
>
>ftp://oss.sgi.com/projects/xfs/download/Release-1.0/patches/linux-2.4.2-kdb-04112001.patch.gz
>is kdb v1.8 against Redhat 7.1.

Correction, that patch is against a standard 2.4.2 kernel.  The closest
I could find is
ftp://oss.sgi.com/projects/xfs/download/testing/Release-1.0.1-PR3/patches/patch-RH2.4.3-xfs-1.0.1-kdb
That is against Rawhide rather than RH 7.1 but it should be fairly
close.  So many patches, so little time :(.

