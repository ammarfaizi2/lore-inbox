Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUJQLmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUJQLmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 07:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269103AbUJQLmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 07:42:06 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:31236 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S269010AbUJQLmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 07:42:04 -0400
Subject: Re: AMD64 Swsusp on 2.6.9-rc4-mm1
From: William Wolf <wwolf@vt.edu>
Reply-To: wwolf@vt.edu
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200410171224.14434.rjw@sisk.pl>
References: <417188EA.4090205@vt.edu> <200410162252.33347.rjw@sisk.pl>
	 <1100589554.7496.2.camel@Xnix>  <200410171224.14434.rjw@sisk.pl>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 12:43:00 -0600
Message-Id: <1100630580.18017.4.camel@Xnix>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 12:24 +0200, Rafael J. Wysocki wrote:
> On Tuesday 16 of November 2004 08:19, William Wolf wrote:
> > Is this supposedly something new in rc4-mm1?  I have been having the
> > same problems since around 2.6.8.1, though i havent gone through every
> > single -mm patch, i have tried at least one in every -rcx candidate, and
> > they have all done this same thing.
> 
> This may be for another reason.  I generally test all of the -rc and -mm 
> patches on an AMD64 box and apparently 2.6.9-rc4-mm1 is the first one that 
> has the problem I was talking about.  AFAICT, the other kernels may fail in a 
> similar way if memory is stuffed with something (eg after updatedb).

Hmmm, ok, well I can boot into other -rcx-mmx kernels and get my output
if that would help any. Usually when i test, i try it immediately after
booting and logging into a console (no X running), so it would be tough
for the memory to be stuffed.

