Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWGaNc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWGaNc1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 09:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWGaNc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 09:32:27 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:45243
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750705AbWGaNc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 09:32:26 -0400
Message-ID: <44CE065B.3080502@microgate.com>
Date: Mon, 31 Jul 2006 08:32:11 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
References: <20060727015639.9c89db57.akpm@osdl.org> <1154112276.3530.3.camel@amdx2.microgate.com> <20060728144854.44c4f557.akpm@osdl.org> <20060728233851.GA35643@muc.de> <1154187239.3404.2.camel@amdx2.microgate.com> <m1lkqc9omh.fsf@ebiederm.dsl.xmission.com> <44CBDB8D.3030209@microgate.com> <20060731053109.GA14453@muc.de>
In-Reply-To: <20060731053109.GA14453@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I dropped the patch now - when Andrew resyncs his tree with
> mine next time it should be fixed.

OK

> Still need to figure out the root cause though.

I have a machine that exhibits the problem
should you want me to test a patch.

-- 
Paul Fulghum
Microgate Systems, Ltd.
