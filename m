Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264089AbTKSOUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTKSOUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:20:21 -0500
Received: from holomorphy.com ([199.26.172.102]:54441 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264089AbTKSOUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:20:18 -0500
Date: Wed, 19 Nov 2003 06:20:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
Message-ID: <20031119142011.GW22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1069246427.5257.12.camel@localhost.localdomain> <20031119130220.GT22764@holomorphy.com> <1069248455.5257.26.camel@localhost.localdomain> <20031119140222.GV22764@holomorphy.com> <1069251503.3390.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069251503.3390.1.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 15:02, William Lee Irwin III wrote:
>> Er, sorry, try this one instead:

On Wed, Nov 19, 2003 at 03:18:23PM +0100, Ronny V. Vindenes wrote:
> bad nopage snd_pcm_mmap_data_nopage+0x0/0xc0 [snd_pcm]
> handle_mm_fault() returned bad status

Fix ETA 5 minutes.


-- wli
