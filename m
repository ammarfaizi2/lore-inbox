Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSLBRak>; Mon, 2 Dec 2002 12:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSLBRak>; Mon, 2 Dec 2002 12:30:40 -0500
Received: from [198.149.18.6] ([198.149.18.6]:47753 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S264715AbSLBRaj>;
	Mon, 2 Dec 2002 12:30:39 -0500
Date: Mon, 2 Dec 2002 19:51:49 -0500
From: Christoph Hellwig <hch@sgi.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021202195149.B25954@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Jeff Garzik <jgarzik@pobox.com>, marcelo@connectiva.com.br,
	rml@tech9.net, linux-kernel@vger.kernel.org
References: <20021202192652.A25938@sgi.com> <3DEB9761.50503@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEB9761.50503@pobox.com>; from jgarzik@pobox.com on Mon, Dec 02, 2002 at 12:24:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 12:24:49PM -0500, Jeff Garzik wrote:
> Adding to that, it is also used for backporting Ingo's workqueue stuff, 
> which is useful and completely separate from the O(1) scheduler.

Hey, that's my next patch :)

