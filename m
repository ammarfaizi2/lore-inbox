Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132578AbRDOGa1>; Sun, 15 Apr 2001 02:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRDOGaR>; Sun, 15 Apr 2001 02:30:17 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44815 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132578AbRDOGaJ>; Sun, 15 Apr 2001 02:30:09 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
Date: 14 Apr 2001 23:29:38 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bbf4i$qs7$1@cesium.transmeta.com>
In-Reply-To: <20010413150219.A440@napalm.go.cz> <20010414002120.A15596@win.tue.nl> <20010414201250.A7260@napalm.go.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010414201250.A7260@napalm.go.cz>
By author:    Jan Dvorak <johnydog@go.cz>
In newsgroup: linux.dev.kernel
>
> On Sat, Apr 14, 2001 at 12:21:20AM +0200, Guest section DW wrote:
> > No, these codes cannot be larger than 127 today.
> > You can use the utility setkeycodes to assign keycodes to these keys.
> I always tought it is 8bit - more-than-128-keys keyboards exists quite long
> time. 
> 

No, the top bit is make/break.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
