Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVBKVod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVBKVod (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVBKVod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:44:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48802 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262354AbVBKVmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:42:50 -0500
Date: Fri, 11 Feb 2005 21:42:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, agk@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device-mapper: multipath
Message-ID: <20050211214248.GA16070@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, agk@redhat.com,
	linux-kernel@vger.kernel.org
References: <20050211171506.GX10195@agk.surrey.redhat.com> <20050211173143.GA11278@infradead.org> <20050211133632.2277fed9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211133632.2277fed9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 01:36:32PM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > +EXPORT_SYMBOL(dm_register_path_selector);
> >  > +EXPORT_SYMBOL(dm_unregister_path_selector);
> > 
> >  I though we agreed to only allow GPL'ed path selectors at OSDL?
> 
> (OSDL?)

Argg, I meant OLS, sorry.

