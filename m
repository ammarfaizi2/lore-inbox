Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWCULmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWCULmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWCULmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:42:15 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:11609 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030352AbWCULmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:42:14 -0500
In-Reply-To: <20060321111452.GA5460@infradead.org>
Subject: Re: [2/3 PATCH] Kprobes: User space probes support- readpage hooks
Sensitivity: 
To: Christoph Hellwig <hch@infradead.org>
Cc: ak@suse.de, Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, prasanna@in.ibm.com, suparna@in.ibm.com
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OF6E2AF906.7E4772F3-ON80257138.003FB875-80257138.003FEBEA@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 21 Mar 2006 11:38:11 +0000
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 21/03/2006 11:42:34
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Christoph Hellwig <hch@infradead.org> wrote on 21/03/2006 11:14:52:

> > A real life example of where this capability would have been very
useful is
> > with a performance problem I am currently investigating. It involves a
GPFS
> > + SAMBA + TCPIP +  RDAC
>
> this pobablt tells more about the crappy code quality of your propritary
> code than a real need for this.   please argue without reference to huge
> blobs of junk.
>

Damn! I knew there was an obvious answer. Thanks Christoph, I'll code a fix
over lunch. Your insight is as always most refreshing.

Richard

