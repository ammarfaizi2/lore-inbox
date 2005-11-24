Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVKXPA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVKXPA6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVKXPA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:00:58 -0500
Received: from relay.axxeo.de ([213.239.199.237]:19355 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S1751312AbVKXPA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:00:57 -0500
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] [PATCH 1/3] ioat: DMA subsystem
Date: Thu, 24 Nov 2005 16:00:50 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
References: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com> <4384F0C4.1090209@pobox.com>
In-Reply-To: <4384F0C4.1090209@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511241600.50046.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jeff Garzik wrote:
> explanation of this function would be nice.  remember to answer "how?" 
> and "why?", not "what?".

Wasn't it the other way around?
Citing linux/Documentation/CodingStyle, section 7 "Comments":

"Generally, you want your comments to tell WHAT your code does, not HOW."

HOW and WHY should be obvious by the source code, unless
the sources are a mess.


Regards

Ingo Oeser

