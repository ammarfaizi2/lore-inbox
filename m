Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWGQOrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWGQOrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 10:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWGQOrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 10:47:31 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:41915 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750810AbWGQOrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 10:47:31 -0400
Date: Mon, 17 Jul 2006 16:47:30 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Vikas Kedia <kedia.vikas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel panic at load average of 24 is it acceptable ?
Message-ID: <20060717144730.GA4383@rhlx01.fht-esslingen.de>
References: <fa.GOIim+nD/em++2ZW3u6yf9zZzH8@ifi.uio.no> <fa.pLqL2zHzVigenRd4nxSUVosmfvk@ifi.uio.no> <44BB9E73.50704@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BB9E73.50704@shaw.ca>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 17, 2006 at 08:28:03AM -0600, Robert Hancock wrote:
> Vikas Kedia wrote:
> >Since it shows ECC error is the hypothesis correct that its the RAM
> >problem and replacing it should solve the problem.
> 
> That looks like a data cache ECC error, which would point to a CPU 
> problem in that case..

(I already suspected the same privately)

IOW, pull the CPU(s), remove any and all dust you can find and reseat
them firmly, then pray and try again.
And a good idea would be to alert your local hardware shop in advance that
you might need new hardware real quick...

Andreas Mohr
