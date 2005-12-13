Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVLMTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVLMTQD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbVLMTQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:16:03 -0500
Received: from mail.kroah.org ([69.55.234.183]:33945 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932258AbVLMTQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:16:01 -0500
Date: Tue, 13 Dec 2005 11:15:32 -0800
From: Greg KH <greg@kroah.com>
To: David Brownell <david-b@pacbell.net>
Cc: Vitaly Wool <vwool@ru.mvista.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Message-ID: <20051213191531.GA13751@kroah.com>
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com> <20051213195317.29cfd34a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512131101.02025.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 11:01:01AM -0800, David Brownell wrote:
> It's way better to just insist that all I/O buffers (in all
> generic APIs) be DMA-safe.  AFAICT that's a pretty standard
> rule everywhere in Linux.

I agree.

greg k-h
