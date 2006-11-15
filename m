Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966596AbWKOHyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966596AbWKOHyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966599AbWKOHyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:54:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40654 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966596AbWKOHyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:54:31 -0500
Subject: Re: 2.6.19-rc5-mm2 -- 3d slow with dynticks
From: Arjan van de Ven <arjan@infradead.org>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <40f323d00611141456i7d538593vaf7e962121b6009d@mail.gmail.com>
References: <40f323d00611141456i7d538593vaf7e962121b6009d@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 15 Nov 2006 08:54:25 +0100
Message-Id: <1163577265.31358.83.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-14 at 23:56 +0100, Benoit Boissinot wrote:
> On 11/14/06, Andrew Morton <akpm@osdl.org> wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/
> >
> 
> CONFIG_NO_HZ=y still gives me slow 3d games on this one whereas
> 2.6.19-rc5-mm1 +
> http://tglx.de/private/tglx/2.6.19-rc5-mm1-dyntick.diff was fine.
> 
> Maybe some patches where not merged ?


what video is this?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

