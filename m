Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275173AbRIZNVe>; Wed, 26 Sep 2001 09:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275179AbRIZNVY>; Wed, 26 Sep 2001 09:21:24 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:54284 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S275173AbRIZNVI>;
	Wed, 26 Sep 2001 09:21:08 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: New generic HDLC available
In-Reply-To: <m3bsoumbtv.fsf@intrepid.pm.waw.pl>
	<3BAA0465.C02DFEB7@cyclades.com>
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 26 Sep 2001 15:11:39 +0200
In-Reply-To: "Daniela P. R. Magri Squassoni"'s message of "Thu, 20 Sep 2001 11:59:49 -0300"
Message-ID: <m34rpqrt9w.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Daniela P. R. Magri Squassoni" <daniela@cyclades.com> writes:

> Are there any news about the inclusion of these changes in the kernel?

I hope so. However, dscc4.c uses the old version. While I think it's
easy to port it to the new one (it should simplify the code in fact),
it has to be done.
-- 
Krzysztof Halasa
Network Administrator
