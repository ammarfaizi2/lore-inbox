Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWJPNe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWJPNe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWJPNe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 09:34:26 -0400
Received: from verein.lst.de ([213.95.11.210]:30425 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750715AbWJPNeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 09:34:25 -0400
Date: Mon, 16 Oct 2006 15:33:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, Dominik Brodowski <linux@brodo.de>,
       Harald Welte <laforge@netfilter.org>, Christoph Hellwig <hch@lst.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: feature-removal-schedule obsoletes
Message-ID: <20061016133352.GA23391@lst.de>
References: <45324658.1000203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45324658.1000203@gmail.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -0.001 () BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 04:31:29PM +0159, Jiri Slaby wrote:
> What:   remove EXPORT_SYMBOL(kernel_thread)
> When:   August 2006
> Who:    Christoph Hellwig <hch@lst.de>

There are a lot of modular users left.  It'll go away as soon as these
users have disappeared.

