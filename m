Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUESP4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUESP4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 11:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbUESP4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 11:56:25 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:26638 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264246AbUESP4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 11:56:23 -0400
Date: Wed, 19 May 2004 16:56:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, pfg@sgi.com,
       Erik Jacobson <erikj@sgi.com>
Subject: Re: [PATCH] implement TIOCGSERIAL in sn_serial.c
Message-ID: <20040519165618.A28238@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, pfg@sgi.com,
	Erik Jacobson <erikj@sgi.com>
References: <200405191109.51751.jbarnes@engr.sgi.com> <200405191138.04086.jbarnes@engr.sgi.com> <20040519164156.A27947@infradead.org> <200405191150.08967.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405191150.08967.jbarnes@engr.sgi.com>; from jbarnes@engr.sgi.com on Wed, May 19, 2004 at 11:50:08AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Umm... I described the patch in the last mail.  I don't know when Pat will 
> have the conversion to the serial core interface done, but I have a need for 
> this ioctl now.  If you want to wait for the full blown version, then so be 
> it, I just hope it comes soon.

And the point of an ioctl copying two values that are compltely irrelevant
for userspace with your driver are? [please fill in here]

