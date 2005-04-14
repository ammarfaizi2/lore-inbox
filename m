Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVDNA1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVDNA1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDNA1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:27:11 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:22200 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261245AbVDNA07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:26:59 -0400
Date: Wed, 13 Apr 2005 20:26:47 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: Fortuna
Message-ID: <20050414002647.GG12263@certainkey.com>
References: <20050413234337.GE12263@certainkey.com> <20050414000939.GH3174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414000939.GH3174@waste.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 05:09:39PM -0700, Matt Mackall wrote:
> On Wed, Apr 13, 2005 at 07:43:37PM -0400, Jean-Luc Cooke wrote:
> > Ahh.  Thanks Herbert.
> > 
> > Matt,
> > 
> > Any insight on how to test syn cookies and the other network stuff in
> > random.c?  My patch is attached, but I havn't tested that part yet.
> 
> For starters, this is not against anything like a current random.c. A
> great number of cleanups have been done.

You caught me.  :)

Last I proposed Fortuna for /dev/random it nearly got me drawn and quarterd.
So I've left it as a kenrel config option, leaving the current random.c
alone.  I thought this was a way to make everyone happy.

JLC
