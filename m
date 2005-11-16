Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVKPRkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVKPRkS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbVKPRkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:40:18 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:19634 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1030262AbVKPRkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:40:16 -0500
Date: Wed, 16 Nov 2005 18:40:21 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Message-ID: <20051116174021.GE24753@wohnheim.fh-wedel.de>
References: <20051115210459.GA11363@kroah.com> <1132162089.21643.87.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1132162089.21643.87.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 November 2005 17:28:09 +0000, David Woodhouse wrote:
> On Tue, 2005-11-15 at 13:05 -0800, Greg KH wrote:
> >  - "Programming the 80386" by Crawford and Gelsinger [Sybek]
> 
> Maybe, but on the whole I suspect we'd do well if fewer people were
> thinking about one particular legacy architecture when writing kernel
> code. 
> 
> Newbie kernel hackers ought to be working on something SMP, big-endian
> and 64-bit. Get into good habits right away.

And make their on-medium format the opposite from their hardware.  It
is so much nicer if a missing conversion here and there _does_ cause
problems.

Jörn

-- 
Correctness comes second.
Features come third.
Performance comes last.
Maintainability is needed for all of them.
