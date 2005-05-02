Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVEBRKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVEBRKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVEBRGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:06:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60042 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261538AbVEBRFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:05:02 -0400
Date: Mon, 2 May 2005 22:47:12 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-ID: <20050502171712.GB4418@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050501190947.GA5204@in.ibm.com> <4275EE8B.5030201@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4275EE8B.5030201@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 07:10:35PM +1000, Nick Piggin wrote:
> Dinakar Guniguntala wrote:
> >Ok, Here is the minimal patchset that I had promised after the
> >last discussion.
> >
> 
> The sched-domains part of it (kernel/sched.c) is looking much
> better now. Haven't had a really good look, but it is definitely
> on the right track now. Well done.
> 
Thank you for reviewing !

	-Dinakar
