Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVBCApD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVBCApD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVBCApC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:45:02 -0500
Received: from maxipes.logix.cz ([217.11.251.249]:44196 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S262359AbVBCAlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:41:10 -0500
Message-ID: <42017316.4070805@logix.cz>
Date: Thu, 03 Feb 2005 13:40:54 +1300
From: Michal Ludvig <michal@logix.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: "David S. Miller" <davem@davemloft.net>, James Morris <jmorris@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dm-crypt@saout.de, cryptoapi@lists.logix.cz
Subject: Re: [PATCH 01/04] Adding cipher mode context information to	crypto_tfm
References: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>	 <1107386909.19339.9.camel@ghanima>	 <20050202153449.1e92c29a.davem@davemloft.net> <1107390095.19339.26.camel@ghanima>
In-Reply-To: <1107390095.19339.26.camel@ghanima>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fruhwirth Clemens wrote:

 > Especially, if James ask me to redo Michal's conflicting patches
 > (done btw), which are totally off-topic for me.

Great, thanks! Has the interface for multiblock modules changed or 
should my old modules work with it with no more effort?

Unfortulately I don't have a PadLock system running at the moment (it is 
still somewhere down in a wooden box after my moving), but if you send 
me the patch I could at least try to compile with my parts.

Thanks for that!

Michal Ludvig
