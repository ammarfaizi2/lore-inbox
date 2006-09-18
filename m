Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965629AbWIRKBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965629AbWIRKBS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965630AbWIRKBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:01:18 -0400
Received: from z2.cat.iki.fi ([212.16.98.133]:44012 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S965629AbWIRKBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:01:18 -0400
Date: Mon, 18 Sep 2006 13:01:16 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vger being silly
Message-ID: <20060918100116.GF16047@mea-ext.zmailer.org>
References: <20060917211731.GQ24822@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060917211731.GQ24822@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 11:17:31PM +0200, Folkert van Heusden wrote:
> Hi,
> 
> Vger is sending e-mails with a negative size:
>  In:  MAIL
>      From:<linux-kernel-owner+folkert=40vanheusden.com-S1750900AbWIQODP@vger.kernel.org>
>      BODY=8BITMIME SIZE=-428652
>  Out: 401 Bad message size syntax
> 
> Folkert van Heusden

  I was very surprised myself -- and I was the reason it happened.
  A manual goofup during junk-filter cleanup.


/Matti Aarnio -- one of  <postmaster@vger.kernel.org>
