Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSGZVcd>; Fri, 26 Jul 2002 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318517AbSGZVcd>; Fri, 26 Jul 2002 17:32:33 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:19346 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S318516AbSGZVcc>;
	Fri, 26 Jul 2002 17:32:32 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Fri, 26 Jul 2002 15:28:32 -0600
To: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix APM notify of apmd for on-AC/on-battery transitions
Message-ID: <20020726152832.L13656@host110.fsmlabs.com>
References: <20020726143345.E13656@host110.fsmlabs.com> <20020726233339.D21176@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020726233339.D21176@suse.de>; from davej@suse.de on Fri, Jul 26, 2002 at 11:33:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fine with me.  As long as my vaio model works right :)

I can dig through there and create a blacklist that has one entry for now.

} But not all Vaio's. My z600 (which is what they sold the z505 series as in .eu)
} for example behaves correctly when I plug in/pull out the power cord
} repeatedly.
} 
} We might be better off special casing 'known bad' models in the
} DMI blacklist instead of assuming carte blanche that all vaio's are bad.
} Might even come down to a specific BIOS version that's at fault.
