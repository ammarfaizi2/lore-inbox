Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311948AbSEEN0q>; Sun, 5 May 2002 09:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSEEN0p>; Sun, 5 May 2002 09:26:45 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:56075 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S311948AbSEEN0o>; Sun, 5 May 2002 09:26:44 -0400
Date: Sun, 5 May 2002 15:26:41 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Chris Rankin <cj.rankin@ntlworld.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18 floppy driver EATS floppies
Message-ID: <20020505132641.GA6031@louise.pinerecords.com>
In-Reply-To: <200205051317.g45DHIU0000750@twopit.underworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 13 days, 7:47)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May  5 13:32:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
> May  5 13:32:37 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
> May  5 13:32:37 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
> May  5 13:32:37 twopit kernel: 2nd bread in fat_access failed
> May  5 13:32:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
> May  5 13:32:38 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
> May  5 13:32:38 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
> May  5 13:32:38 twopit kernel: bread in fat_access failed
> May  5 13:32:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
> May  5 13:32:39 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
> May  5 13:32:39 twopit kernel: end_request: I/O error, dev 02:00 (floppy), sector 5
> May  5 13:32:39 twopit kernel: bread in fat_access failed
> May  5 13:32:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2
> May  5 13:32:40 twopit kernel: floppy0: sector not found: track 0, head 0, sector 6, size 2


You realise you had just sent 90K of junk to thousands of people?
