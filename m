Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270634AbUJULaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270634AbUJULaK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 07:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269072AbUJUJvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:51:25 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:11739 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S269056AbUJUJn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:43:26 -0400
Message-ID: <417784BC.1060707@verizon.net>
Date: Thu, 21 Oct 2004 05:43:24 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
References: <4176CFE3.2030306@verizon.net> <20041020153058.6de41ed8.akpm@osdl.org> <4176EBD8.3050306@verizon.net> <20041021042036.GB14189@redhat.com> <41773D3F.2040801@verizon.net> <20041020220037.2e209907.akpm@osdl.org> <20041021050528.GA26814@redhat.com>
In-Reply-To: <20041021050528.GA26814@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.211.53] at Thu, 21 Oct 2004 04:43:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Oct 20, 2004 at 10:00:37PM -0700, Andrew Morton wrote:
>  > >  The other possibility is to have a TODO file with a list of out-of-date 
>  > >  files, and have the removal of the file listing in the TODO file be part 
>  > >  of the patch submission.
>  > 
>  > It all sounds too complex.  ./docs/ is fine.
> 
> asides from bloating up interdiffs, what does moving stuff around
> gain us over just fixing stuff in place ?  Do we really have
> that much out of date documentation to justify this ?
> 
> 		Dave
> 
> 
Well, before I started this thread, I actually looked through the root 
Documentation directory, taking notes, and there were 40 files that were 
definitely out of date, and 10 that were not obviously out of date, but 
had no indication that it had been updated recently.

That's without digging into the subdirectories.

Jim
