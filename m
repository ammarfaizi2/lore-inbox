Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbUBZNEV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbUBZNEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:04:21 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:7393 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S262781AbUBZNEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:04:15 -0500
Date: Thu, 26 Feb 2004 13:02:49 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: linux-kernel@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Dan Kegel <dank@kegel.com>,
       Sean McGoogan <sean.mcgoogan@superh.com>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040226130249.GD16667@malvern.uk.w2k.superh.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Paul Mundt <lethal@linux-sh.org>, Dan Kegel <dank@kegel.com>,
	Sean McGoogan <sean.mcgoogan@superh.com>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <20040222155209.GA11162@linux-sh.org> <20040222170720.GA24703@MAIL.13thfloor.at> <20040222172307.GB11162@linux-sh.org> <20040223132819.GB16667@malvern.uk.w2k.superh.com> <20040223144149.GC4092@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223144149.GC4092@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 26 Feb 2004 13:04:50.0241 (UTC) FILETIME=[1E0C8B10:01C3FC69]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb, 2004 at  3:41pm, Herbert Poetzl wrote:
> On Mon, Feb 23, 2004 at 01:28:19PM +0000, Richard Curnow wrote:
> > 
> > The last public release we made of the SH-5 tools is available at
> > 
> >     ftp://ftp.uk.superh.com/pub/SuperH-GNU/Barcelona-20030414
> 
> how are they related to the 'mainline' toolchain?

This release equated to something like gcc 3.2.1 + some work from the
3.3 branch + some in-house work.

> i.e. is this something completely separate, or do you follow the
> binutils/gcc updates from time to time?

No, it's not completely separate.  We do follow the mainline tree
(largely via gcc CVS rather than released tarballs), though we tend to
have fairly long periods between such 'rebaselinings'.

> what would be the binutils/gcc version which is 'closest' to 'your'
> toolchain? wouldn't it make sense to get those changes back into the
> mainline?

A lot of changes have already gone into the mainline gcc 3.4 branch.

As for binutils, I assume the position is similar, but I've not checked
the details.

> > The SH-5 tools we're currently using in-house are a few months more
> > advanced than those.  (They date from about August 2003.)  We'd be
> > happy to package this version up and make it available if people
> > express interest in this.
> 
> sure I'm interested *expressing interest*

OK.  Acknowleged.  BTW that version has the same basic ancestry as the
April 14th version, it just has some additional in-house fixes in it.

HTH
Richard

-- 
Richard \\\ SH-4/SH-5 Core & Debug Architect
Curnow  \\\         SuperH (UK) Ltd, Bristol
