Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVABUbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVABUbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVABUbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:31:33 -0500
Received: from verein.lst.de ([213.95.11.210]:62597 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261326AbVABUaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:30:14 -0500
Date: Sun, 2 Jan 2005 21:30:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] disallow modular capabilities
Message-ID: <20050102203005.GA9491@lst.de>
References: <20050102200032.GA8623@lst.de> <m1mzvry3sf.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mzvry3sf.fsf@muc.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 09:28:00PM +0100, Andi Kleen wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > There's been a bugtraq report about a root exploit with modular
> > capabilities LSM support out for more than a week.
> 
> It was a root exploit only triggerable by root. Not exactly
> what I would call a real problem.

At least Debian currently inserts the capabilities module on boot.

