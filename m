Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316367AbSEQQio>; Fri, 17 May 2002 12:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316388AbSEQQin>; Fri, 17 May 2002 12:38:43 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:7694 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S316367AbSEQQin>;
	Fri, 17 May 2002 12:38:43 -0400
Date: Fri, 17 May 2002 09:38:42 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Athanasius <Athanasius@miggy.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Just an offer
Message-ID: <20020517093842.D9190@ecam.san.rr.com>
In-Reply-To: <20020517141928.GC6613@louise.pinerecords.com> <Pine.LNX.3.95.1020517103006.143A-100000@chaos.analogic.com> <20020517163024.GB17483@miggy.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 05:30:24PM +0100, Athanasius wrote:
>    It strikes me that this is also in part a LILO 'problem'.  We could
> use some way to tell LILO to only boot a given image _once_ as the
> default, and thence reboot to the normal default.  Combine this with any

lilo -R test-image

Just in case you fail in your check.
 
> -Ath, checking the LILO docs to see if it does something like this
> already...
