Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVCWJiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVCWJiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 04:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVCWJiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 04:38:46 -0500
Received: from 213-239-234-136.clients.your-server.de ([213.239.234.136]:50606
	"EHLO suckfuell.net") by vger.kernel.org with ESMTP id S261182AbVCWJio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 04:38:44 -0500
Date: Wed, 23 Mar 2005 10:38:44 +0100
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 bug: unbacked private shared memory segments missing in core dump
Message-ID: <20050323093844.GA6962@ds217-115-141-141.dedicated.hosteurope.de>
Mail-Followup-To: Jochen Suckfuell <jo-lkml@suckfuell.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050301170614.GA6121@ds217-115-141-141.dedicated.hosteurope.de> <20050308134332.GA2356@ds217-115-141-141.dedicated.hosteurope.de> <20050321152948.475676f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321152948.475676f4.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 21, 2005 at 03:29:48PM -0800, Andrew Morton wrote:
> Jochen Suckfuell <jo-lkml@suckfuell.net> wrote:
> >
> > Hello!
> > 
> > Since 2.6.10, unbacked private shared memory allocated via shmget is not
> > included in core dumps.
> 
> Can you please confirm that 2.6.12-rc1 fixed this?

Yes, it's fixed. 

Thanks to everyone involved.


Bye
Jochen Suckfuell

