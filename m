Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266664AbUFWUyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266664AbUFWUyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbUFWUyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:54:43 -0400
Received: from [213.146.154.40] ([213.146.154.40]:25756 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266664AbUFWUyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:54:38 -0400
Date: Wed, 23 Jun 2004 21:54:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ks@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: Why dentry->d_qstr change in 2.6.7 ?
Message-ID: <20040623205435.GA30022@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, ks@cs.auc.dk,
	linux-kernel@vger.kernel.org
References: <1087660293.30405.47.camel@localhost> <1087999469.10863.0.camel@localhost> <20040623141027.GA23278@infradead.org> <20040623135537.3e4f4072.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040623135537.3e4f4072.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 01:55:37PM -0700, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Jun 23, 2004 at 04:04:29PM +0200, Kristian Sørensen wrote:
> > > Can it really be, that noone knows why this change has been made !??
> > 
> > There's certainly people who know.  Look into the changelog to read
> > what they have to say.
> > 
> 
> afaik there is no way to obtain changelog information from the BK web
> interface, which is a significant shortcoming.

Oh, okay.  Sorry for the RTFM then.  On the otherhand there's been an
url of a discussion on lwn.net posted now, so..
