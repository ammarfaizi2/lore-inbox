Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270625AbUJUFJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270625AbUJUFJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 01:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270658AbUJUFJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 01:09:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:22155 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270625AbUJUFJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 01:09:13 -0400
Date: Wed, 20 Oct 2004 22:07:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: james4765@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
Message-Id: <20041020220700.4636104f.akpm@osdl.org>
In-Reply-To: <20041021050528.GA26814@redhat.com>
References: <4176CFE3.2030306@verizon.net>
	<20041020153058.6de41ed8.akpm@osdl.org>
	<4176EBD8.3050306@verizon.net>
	<20041021042036.GB14189@redhat.com>
	<41773D3F.2040801@verizon.net>
	<20041020220037.2e209907.akpm@osdl.org>
	<20041021050528.GA26814@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
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

Well I was thinking of it as a simple way of tracking what has and hasn't
been done.  But yeah, that could just as easily be tracked via a new
checklist file.

