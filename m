Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWAPMqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWAPMqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWAPMqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:46:50 -0500
Received: from ns.suse.de ([195.135.220.2]:63897 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750712AbWAPMqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:46:49 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] use usual call trace format on x86-64
Date: Mon, 16 Jan 2006 13:46:32 +0100
User-Agent: KMail/1.8.2
Cc: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org
References: <20060116121611.GA539@miraclelinux.com> <200601161322.41633.ak@suse.de> <20060116123216.GA13248@infradead.org>
In-Reply-To: <20060116123216.GA13248@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601161346.33048.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 13:32, Christoph Hellwig wrote:
> On Mon, Jan 16, 2006 at 01:22:41PM +0100, Andi Kleen wrote:
> > On Monday 16 January 2006 13:18, Akinobu Mita wrote:
> > > Use print_symbol() to dump call trace.
> > 
> > Rejected.
> 
> Why?  This is a lot more readable than what's there, and similar to other
> architectures.

See my reply to 0/0

-Andi
