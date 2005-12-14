Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964931AbVLNUSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964931AbVLNUSz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVLNUSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:18:55 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:35957 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964931AbVLNUSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:18:54 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI: add async message handing library
Date: Wed, 14 Dec 2005 11:31:42 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213170629.7240d211.vwool@ru.mvista.com>
In-Reply-To: <20051213170629.7240d211.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512141131.42935.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 6:06 am, Vitaly Wool wrote:
> Greetings,
> 
> as a part of the convergence process between two SPI cores ...
> I'd like to post here one more result of mindwork :). ...
>	 this is a port of the library 
> for handling async SPI messages using kernel threads, one per each
> SPI controller, from our core to David's.       

I'll have to take some time to look at this; I had planned
to evolve the spi_bitbang framework a bit more.  It's already
working (parport/pc), but needs some improvements.

Just wanted you to not expect a response Real Soon Now, since
there are other things I have to do too.  :)

- Dave

