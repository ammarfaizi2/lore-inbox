Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751505AbWFUL6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbWFUL6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWFUL6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:58:43 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:40369 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1751505AbWFUL6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:58:43 -0400
Date: Wed, 21 Jun 2006 07:58:17 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Kyle McMartin <kyle@parisc-linux.org>, jeremy@goop.org,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk,
       chrisw@sous-sol.org
Subject: Re: [PATCH] Implement kasprintf
Message-ID: <20060621115817.GA3948@tachyon.int.mcmartin.ca>
References: <44988B5C.9080400@goop.org> <20060621030444.GG20625@skunkworks.cabal.ca> <20060620202617.f39d7ca6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060620202617.f39d7ca6.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 08:26:17PM -0700, Andrew Morton wrote:
> 
> asprintf() doesn't take a gfp_t arg.
> 

Good point. :)

Cheers,
	Kyle
