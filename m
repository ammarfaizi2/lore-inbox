Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313325AbSDUNxT>; Sun, 21 Apr 2002 09:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313327AbSDUNxS>; Sun, 21 Apr 2002 09:53:18 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:29196 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313325AbSDUNxR>;
	Sun, 21 Apr 2002 09:53:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.1 is available 
In-Reply-To: Your message of "Sun, 21 Apr 2002 17:43:08 +1000."
             <27268.1019374988@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 21 Apr 2002 23:53:05 +1000
Message-ID: <28598.1019397185@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002 17:43:08 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>   kbuild-2.5-common-2.5.8-1.bz2

That file has a one bit error on download[*] and fails the bunzip CRC
checks.  New copy uploaded as kbuild-2.5-common-2.5.8-3.bz2.  No
change, new name to defeat http caching.  -2 had the same problem,
hence -3.

[*] Might be the upload, might be sourceforge, might be the local
    Telstra web proxy.  DKDC, do a fresh copy just in case.

