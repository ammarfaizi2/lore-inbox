Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278867AbRJVUPU>; Mon, 22 Oct 2001 16:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278868AbRJVUPL>; Mon, 22 Oct 2001 16:15:11 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:58508 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278867AbRJVUOz>; Mon, 22 Oct 2001 16:14:55 -0400
Date: Mon, 22 Oct 2001 16:15:27 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: John Hawkes <hawkes@oss.sgi.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] gcc 3.0.1 warnings about multi-line literals
Message-ID: <20011022161527.K23213@redhat.com>
In-Reply-To: <200110222005.f9MK5AJ15012@oss.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110222005.f9MK5AJ15012@oss.sgi.com>; from hawkes@oss.sgi.com on Mon, Oct 22, 2001 at 01:05:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 01:05:10PM -0700, John Hawkes wrote:
> This patch eliminates gcc 3.0.1 warnings, "multi-line string literals are
> deprecated", in two include/asm-i386 files.  Patches cleanly for at least
> 2.4.10 and 2.4.12, and tested in 2.4.10.

Please reject this patch.  The gcc folks are wrong in this case.

		-ben
