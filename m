Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291962AbSBAUNb>; Fri, 1 Feb 2002 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291967AbSBAUNV>; Fri, 1 Feb 2002 15:13:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44562 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291962AbSBAUND>; Fri, 1 Feb 2002 15:13:03 -0500
Message-ID: <3C5AF6B5.5080105@zytor.com>
Date: Fri, 01 Feb 2002 12:12:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201124300.G763@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> 
> Maybe, i8XX hardware RNG should feed the /dev/random entropy pool
> directly if you enable the chipset support (with an option to turn
> it off if you want to use the user-space tools or a separate RNG),
> so that people get the benefits of the h/w RNG without having to
> install another tool (which they won't know about)?
> 


"Let's put it in the kernel because people are too stupid to install it
otherwise"?

No thank you.

	-hpa


