Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVASKYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVASKYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 05:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVASKYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 05:24:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2452 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261654AbVASKYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 05:24:02 -0500
Date: Wed, 19 Jan 2005 10:20:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] bttv: make some code static
Message-ID: <20050119102015.GA12485@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerd Knorr <kraxel@bytesex.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
	linux-kernel@vger.kernel.org
References: <20050119045726.GN1841@stusta.de> <20050119094351.GA31247@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119094351.GA31247@bytesex>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 10:43:52AM +0100, Gerd Knorr wrote:
> > This patch was already sent on:
> > - 9 Nov 2004
> 
> Damn, yes.  I have it.  I don't consider those patches *that* important
> that I instantly forward the stuff, they'll go out with the next batch
> of v4l updates because it's less work that way.

It's usally considered a good idea to ACK a patch when you got it and
think it's okay.  

