Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWIUV5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWIUV5V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWIUV5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:57:21 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:35593 "EHLO
	BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751647AbWIUV5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:57:20 -0400
Message-ID: <BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Thu, 21 Sep 2006 17:57:17 -0400
From: Sean <seanlkml@sympatico.ca>
To: Dax Kelson <dax@gurulabs.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-Id: <20060921175717.272c58ee.seanlkml@sympatico.ca>
In-Reply-To: <1158874875.24172.47.camel@mentorng.gurulabs.com>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com>
	<20060921204250.GN13641@csclub.uwaterloo.ca>
	<20060921171747.9ae2b42e.seanlkml@sympatico.ca>
	<1158874875.24172.47.camel@mentorng.gurulabs.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2006 21:57:19.0166 (UTC) FILETIME=[E8911DE0:01C6DDC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 15:41:15 -0600
Dax Kelson <dax@gurulabs.com> wrote:

> 
> Git users and tarball users are different audiences.
> 

Don't see why that needs to be the case.  Git can even produce the
tarballs once you've synced up with kernel.org (see git-tar-tree).
People interested in conserving bandwidth should really consider
the use of Git.

Sean
