Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWCULq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWCULq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030361AbWCULq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:46:26 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:53175 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030360AbWCULqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:46:25 -0500
In-Reply-To: <20060321112807.GB5460@infradead.org>
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Sensitivity: 
To: Christoph Hellwig <hch@infradead.org>
Cc: ak@suse.de, Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, prasanna@in.ibm.com, suparna@in.ibm.com
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OF765C98CD.EB612716-ON80257138.00400490-80257138.00405953@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 21 Mar 2006 11:42:51 +0000
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/03/2006 11:46:47
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Christoph Hellwig <hch@infradead.org> wrote on 21/03/2006 11:28:07:

> On Mon, Mar 20, 2006 at 06:12:55PM -0800, Andrew Morton wrote:
> > What does this entire feature *do*?  Why does Linux need it?
>
> it's what dtrace does.  thus the marketing departments at ibm and redhat
> decided to copy the features 1:1 instead of thinking what problem they
> want to solve.
>

I think you'll find it happened the other way round. Sun openly references
my white papers. They even stole the name of an ancestor to kprobes. But
who cares, it not relevant or particularly interesting whether the chicken
or the egg came first.

