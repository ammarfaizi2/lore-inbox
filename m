Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbTFBVFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 17:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTFBVFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 17:05:34 -0400
Received: from gw.netgem.com ([195.68.2.34]:2570 "EHLO gw.dev.netgem.com")
	by vger.kernel.org with ESMTP id S263979AbTFBVFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 17:05:32 -0400
Subject: Re: [BUG] ieee1394 sbp2 driver is broken for kernel >= 2.4.21-rc2
From: Jocelyn Mayer <jma@netgem.com>
To: Georg Nikodym <georgn@somanetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030602163443.2bd531fb.georgn@somanetworks.com>
References: <1054582582.4967.48.camel@jma1.dev.netgem.com>
	 <20030602163443.2bd531fb.georgn@somanetworks.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054588832.4967.77.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Jun 2003 23:20:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 22:34, Georg Nikodym wrote:
> On 02 Jun 2003 21:36:22 +0200
> Jocelyn Mayer <jma@netgem.com> wrote:
> 
> > ... at least for PPC targets.
> 
> As a datapoint, works fine for me with my x86 laptop:

Hi,

OK, so it should be an endianness related problem...
I didn't test this on a PC because I need (want ?)
to always use the same kernel on my Mac & my PC
so I can test my patches always in the same conditions.
It gives me a start point to investigate...

Regards.


-- 
Jocelyn Mayer <jma@netgem.com>
> 

