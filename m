Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWFXSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWFXSKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWFXSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:10:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63929 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751016AbWFXSKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:10:04 -0400
Date: Sat, 24 Jun 2006 19:09:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Change in-kernel afs client filesystem name to 'kafs'
Message-ID: <20060624180953.GA4145@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Troy Benjegerdes <hozer@hozed.org>,
	Arjan van de Ven <arjan@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
References: <20060624004154.GL5040@narn.hozed.org> <1151151360.3181.34.camel@laptopd505.fenrus.org> <20060624180136.GO5040@narn.hozed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624180136.GO5040@narn.hozed.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 01:01:41PM -0500, Troy Benjegerdes wrote:
> Now, if you could suggest another way to have both the *experimental* 
> in-kernel AFS client and OpenAFS client with mounted filesystems, please
> let me know.

Don't do that.  Or at least stay far away from the vger lists with any
bugreports or suggestions that come up when running OpenAFS.  It's some
of the worst code around, and it has a license that doesn't event permit 
the blatantly stupid poking into kernel internals it does.

