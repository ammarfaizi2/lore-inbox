Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVGFLdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVGFLdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 07:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVGFLdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 07:33:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1695 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262119AbVGFI4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:56:51 -0400
Date: Wed, 6 Jul 2005 09:56:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: ninja@slaphack.com, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Message-ID: <20050706085646.GB21650@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>, ninja@slaphack.com,
	linux-kernel@vger.kernel.org
References: <200507042032.j64KWiY9009684@laptop11.inf.utfsm.cl> <42CB0A40.3070903@slaphack.com> <877jg4an70.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877jg4an70.fsf@jbms.ath.cx>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 06:43:31PM -0400, Jeremy Maitin-Shepard wrote:
> > Let's say cryptocompress gets implemented.  Not all of userland
> > rewritten, not even any of userland rewritten, just a cryptocompress
> > plugin for the kernel.  And instead of having to learn a new tool, I can
> > just browse around in /meta.
> 
> What is the relationship between file-as-dir or special meta-data and
> transparent encryption+compression?  I do not see why file-as-dir would
> require such a special interface.

It's not related at all.  transparent encryption+compression is a nice
extension.

