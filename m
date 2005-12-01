Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVLAVS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVLAVS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVLAVS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:18:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:58822 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932479AbVLAVS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:18:27 -0500
Subject: Re: 2.6.15-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051201113158.GE3958@infradead.org>
References: <20051129203134.13b93f48.akpm@osdl.org>
	 <20051130162324.GA15273@infradead.org> <1133392706.16726.91.camel@gaston>
	 <20051201113158.GE3958@infradead.org>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 08:10:59 +1100
Message-Id: <1133471459.6100.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 11:31 +0000, Christoph Hellwig wrote:
> On Thu, Dec 01, 2005 at 10:18:25AM +1100, Benjamin Herrenschmidt wrote:
> > Aren't UARTs driven by this driver also compatible with the 8250 one ?
> 
> I don't think so. It's a pretty complicated "intelligent" serial board.

Hrm... ok, well, we have a board here based on Exar chips that can be
driven by the "jsm" driver but it also works fine with 8250...

Ben.


