Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWIUVRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWIUVRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWIUVRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:17:50 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:8365 "EHLO
	BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751572AbWIUVRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:17:49 -0400
Message-ID: <BAYC1-PASMTP11A764536EF320027345F8AE200@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Thu, 21 Sep 2006 17:17:47 -0400
From: Sean <seanlkml@sympatico.ca>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Dax Kelson <dax@gurulabs.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-Id: <20060921171747.9ae2b42e.seanlkml@sympatico.ca>
In-Reply-To: <20060921204250.GN13641@csclub.uwaterloo.ca>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com>
	<20060921204250.GN13641@csclub.uwaterloo.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2006 21:25:52.0453 (UTC) FILETIME=[83FF8F50:01C6DDC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 16:42:50 -0400
Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:

> On Thu, Sep 21, 2006 at 02:32:57PM -0600, Dax Kelson wrote:
> > Today as I was watching the linux-2.6.18.tar.bz2 slowly download I
> > thought it would be nice if it could be made smaller.
[...]
> But after you download it once, you can just get the diff next time.
> How is the decompression time on 7zip versus bzip2 and gzip?

Not to mention that by using Git it will take care of all that for you.
Downloading only the updates with no need for you to manually apply diffs
etc..

Sean
