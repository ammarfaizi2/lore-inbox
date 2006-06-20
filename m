Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWFTUhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWFTUhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFTUhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:37:35 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:33179
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750970AbWFTUhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:37:34 -0400
Message-ID: <44985C89.3040000@microgate.com>
Date: Tue, 20 Jun 2006 15:37:29 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shaun Jackman <sjackman@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: TL16C752B DUART: MCR_OUT2 disables interrupts
References: <7f45d9390606201307yfdb8aadn4d00a6afeba0b09b@mail.gmail.com>	 <44985A07.9080807@microgate.com> <7f45d9390606201335x29957bfcy31dd4ece97d551ea@mail.gmail.com>
In-Reply-To: <7f45d9390606201335x29957bfcy31dd4ece97d551ea@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaun Jackman wrote:
> On 6/20/06, Paul Fulghum <paulkf@microgate.com>
> I didn't know of this historic use of the OUT2 pin to disable
> interrupts. I'll put OUT2 on my list of things not to muck with. Is
> there any similar historic use of OUT1?

Not that I'm aware of. All of the old designs I've
seen left that signal unconnected.

-- 
Paul Fulghum
Microgate Systems, Ltd.
