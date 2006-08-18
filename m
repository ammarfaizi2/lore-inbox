Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWHRGSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWHRGSt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWHRGSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:18:49 -0400
Received: from msr24.hinet.net ([168.95.4.124]:42119 "EHLO msr24.hinet.net")
	by vger.kernel.org with ESMTP id S1750904AbWHRGSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:18:48 -0400
Message-ID: <030001c6c28e$18008670$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "David Gomez" <david@pleyades.net>
Cc: <romieu@fr.zoreil.com>, <penberg@cs.Helsinki.FI>, <akpm@osdl.org>,
       <dvrabel@cantab.net>, <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>
References: <1155843809.5006.6.camel@localhost.localdomain> <20060817110934.GA5504@fargo>
Subject: Re: [PATCH 2/7] ip1000: remove some default phy params
Date: Fri, 18 Aug 2006 14:18:16 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David:

Ok, I will add sign-off-by latter. Thanks for that.

Jesse Huang
----- Original Message ----- 
From: "David Gomez" <david@pleyades.net>
To: "Jesse Huang" <jesse@icplus.com.tw>
Cc: <romieu@fr.zoreil.com>; <penberg@cs.Helsinki.FI>; <akpm@osdl.org>;
<dvrabel@cantab.net>; <linux-kernel@vger.kernel.org>;
<netdev@vger.kernel.org>
Sent: Thursday, August 17, 2006 7:09 PM
Subject: Re: [PATCH 2/7] ip1000: remove some default phy params


Hi Jesse,

On Aug 17 at 03:43:29, Jesse Huang wrote:
> From: Jesse Huang <jesse@icplus.com.tw>
>
> remove some default phy params
>
> Change Logs:
>     remove some default phy params

First, thanks for finalling commiting this driver ;).

But please resend the patches with "Signed-off-by:"
line. I'm not much of a git hacker, but i think you
can use 'git-applymbox' to put a signedoff line in your
mbox-formatted patches.

regards,

-- 
David Gomez                                      Jabber ID:
davidge@jabber.org


