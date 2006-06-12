Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWFLIkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWFLIkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 04:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWFLIkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 04:40:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16144 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751053AbWFLIkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 04:40:19 -0400
Date: Mon, 12 Jun 2006 09:40:12 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matti Aarnio <matti.aarnio@zmailer.org>, zwane@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
Message-ID: <20060612084012.GA7291@flint.arm.linux.org.uk>
Mail-Followup-To: Matti Aarnio <matti.aarnio@zmailer.org>,
	zwane@holomorphy.com, linux-kernel@vger.kernel.org
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <20060611072223.GA16150@flint.arm.linux.org.uk> <20060612083239.GA27502@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612083239.GA27502@mea-ext.zmailer.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 11:32:39AM +0300, Matti Aarnio wrote:
> SPF is application level version of this type of source sanity
> enforcement, and all that I intend to do is to publish that TXT
> entry for VGER.  Analyzing SPF data in incoming SMTP reception
> is a thing that I leave for latter phase  (how much latter,
> I can't say yet.)

In which case I have no option but to ask - Zwane, please stop using
my systems to forward your lkml email - Matti's proposed change will
potentially break that setup.

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
