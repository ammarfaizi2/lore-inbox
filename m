Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbVBKWyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbVBKWyf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVBKWyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:54:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262157AbVBKWyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:54:31 -0500
Date: Fri, 11 Feb 2005 22:54:21 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath
Message-ID: <20050211225421.GJ14093@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20050211171506.GX10195@agk.surrey.redhat.com> <20050211173143.GA11278@infradead.org> <20050211133632.2277fed9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211133632.2277fed9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:36:32PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> > > +EXPORT_SYMBOL(dm_register_path_selector);
> >  > +EXPORT_SYMBOL(dm_unregister_path_selector);

> Yup, this should be _GPL.  

Yup - and the same applies to the other exports.

Alasdair
-- 
agk@redhat.com
