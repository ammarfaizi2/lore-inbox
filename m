Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVLNUVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVLNUVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbVLNUVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:21:21 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:59815 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964939AbVLNUVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:21:20 -0500
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] Re: [PATCH/RFC] SPI: add DMAUNSAFE analog
Date: Wed, 14 Dec 2005 11:33:33 -0800
User-Agent: KMail/1.7.1
Cc: Vitaly Wool <vwool@ru.mvista.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512141102.53599.david-b@pacbell.net> <43A07050.30603@ru.mvista.com>
In-Reply-To: <43A07050.30603@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512141133.34634.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So just answer please yes or no: are your spi_wXrY functions intended 
> for usage at all or not?

Certainly.  Not _mis_used though.
