Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUAGL05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266191AbUAGL05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:26:57 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:59652 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266187AbUAGL0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:26:51 -0500
Date: Wed, 7 Jan 2004 11:26:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@wildopensource.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow SGI IOC4 chipset support
Message-ID: <20040107112648.A27801@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@wildopensource.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040106010924.GA21747@sgi.com> <20040106102538.A14492@infradead.org> <yq04qv8ypkp.fsf@wildopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <yq04qv8ypkp.fsf@wildopensource.com>; from jes@wildopensource.com on Wed, Jan 07, 2004 at 06:18:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 06:18:30AM -0500, Jes Sorensen wrote:
> What about adding this?
> 
> Though shall not use weak symbols in though kernel ....

That's stupid.  You should just not be allowed to compile the driver
if it can work anywork.

