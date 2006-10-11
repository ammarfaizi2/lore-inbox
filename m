Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWJKG4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWJKG4b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWJKG4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:56:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7571 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932250AbWJKG4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:56:30 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1160518635.28299.1.camel@dyn9047017100.beaverton.ibm.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <1160518635.28299.1.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 08:56:26 +0200
Message-Id: <1160549786.3000.345.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 15:17 -0700, Badari Pulavarty wrote:
> On Tue, 2006-10-10 at 00:09 -0700, Andrew Morton wrote: 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> 
> 
> I hate to report always failures, I hope you don't hate me
> for that :)
> 
> My EM64T box doesn't boot -mm1. Seems like IRQ problem ?
> Starting Avahi daemon: do_IRQ: 0.57 No irq handler for vector


I'm seeing something simliar (different number though) a few minutes
after boot with yesterdays git snapshot... something is sick in irq
land...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

