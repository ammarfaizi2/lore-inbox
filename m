Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265219AbUFVS2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbUFVS2U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUFVSTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:19:37 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:38104 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S265092AbUFVRwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:52:15 -0400
Date: Tue, 22 Jun 2004 20:52:01 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Stephen Hemminger <shemminger@osdl.org>
cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, lartc@mailman.ds9a.nl
Subject: Re: [LARTC] [ANNOUNCE] sch_ooo - Out-of-order packet queue discipline
In-Reply-To: <20040622084607.4996569f@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.60.0406222051240.17140@hosting.rdsbv.ro>
References: <Pine.LNX.4.58.0404021023140.18886@hosting.rdsbv.ro>
 <20040622084607.4996569f@dell_ss3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004, Stephen Hemminger wrote:

> Maybe the delay and ooo scheduler should be merged, the both do sort of
> the same thing.

Yes, it's true.
I can work on a patch if you want.

---
Catalin(ux aka Dino) BOIE
catab at deuroconsult.ro
http://kernel.umbrella.ro/
