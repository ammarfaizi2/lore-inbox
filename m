Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTFFAKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 20:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTFFAKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 20:10:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39822
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265264AbTFFAKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 20:10:13 -0400
Subject: Re: hpt374 driver question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Anderson <dave@halogensunlight.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0306060020160.18421-100000@zion.matrix>
References: <Pine.LNX.4.21.0306060020160.18421-100000@zion.matrix>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054858877.15458.56.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jun 2003 01:21:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-06 at 00:26, David Anderson wrote:
> Hi,
> 
> I've finally manage to get my onboard hpt374 controller recognized under
> 2.5.70. The controller and drives(hdi & hdk) are correctly reported at
> boot time but I can't work out how to access the RAID array. I've tried
> things like /dev/sdx and dev/ataraid with no luck. Can anyone tell me how
> to access the RAID array?

The ideraid code hasnt been ported from 2.4 yet

