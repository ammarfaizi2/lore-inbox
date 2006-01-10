Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbWAJU0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbWAJU0X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWAJU0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:26:23 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28986 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932592AbWAJU0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:26:22 -0500
Date: Tue, 10 Jan 2006 21:28:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Bernd Eckenfels <be-mail2006@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2G memory split
Message-ID: <20060110202819.GJ3389@suse.de>
References: <43C3E9C2.1000309@rtr.ca> <E1EwNc8-00063F-00@calista.inka.de> <20060110194200.GD3389@suse.de> <20060110201747.GA26433@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110201747.GA26433@lina.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Bernd Eckenfels wrote:
> On Tue, Jan 10, 2006 at 08:42:00PM +0100, Jens Axboe wrote:
> > Hmm I thought it was obvious with the description in paranthesis after
> > the option. Basically the option is just an optimized default for 1GB of
> > RAM, like the 2G option is tailored for 2GB of low mem on a 2GB machine.
> 
> The description was (for full 1Gb Low Memory) and not (optimized for 1GB
> physical RAM) which would be more obvious, yes. However the text could still
> explain the consequences.

To me the former is clearer, it tells you that you have one full gig of
low memory. But maybe that's just me.

-- 
Jens Axboe

