Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271037AbTGQPrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271041AbTGQPro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:47:44 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:16646 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271037AbTGQPrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:47:18 -0400
Date: Thu, 17 Jul 2003 17:01:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: __put_task_struct
Message-ID: <20030717170156.B9432@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Frank Cornelis <Frank.Cornelis@elis.ugent.be>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1058367495.1073.10.camel@tom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1058367495.1073.10.camel@tom>; from Frank.Cornelis@elis.ugent.be on Wed, Jul 16, 2003 at 04:58:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 04:58:15PM +0200, Frank Cornelis wrote:
> 
> Hi,
> 
> When using get/put_task_struct from inside a module, kbuild warns about
> __put_task_struct being undefined. Can someone export this function?

Why would you use it in a module?

