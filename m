Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVFULsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVFULsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFUL0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:26:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21944 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261194AbVFULNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:13:02 -0400
Date: Tue, 21 Jun 2005 07:13:01 -0400
From: Dave Jones <davej@redhat.com>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.12
Message-ID: <20050621111301.GA592@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Richard B. Johnson" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0506200857450.5213@chaos.analogic.com> <20050621003203.GB28908@redhat.com> <Pine.LNX.4.61.0506210629110.8815@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506210629110.8815@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 06:32:32AM -0400, Richard B. Johnson wrote:

 > Bullshit. The source is available to anybody who wants it.

Great. Then please explain why you pull off this kind of crap..
(DataLink/license.c)

//
//   This program may be distributed under the GNU Public License
//   version 2, as published by the Free Software Foundation, Inc.,
//   59 Temple Place, Suite 330 Boston, MA, 02111.
//
//
#ifndef __KERNEL__
#define __KERNEL__
#endif
#ifndef MODULE
#define MODULE
#endif
#include <linux/module.h>
#if defined(MODULE_LICENSE)
MODULE_LICENSE("GPL\0 They won't allow GPL/BSD anymore!");
#endif

 > It's worthless without fiber-optic data-link boards that it
 > supports.

That's not the point. I've not had the hardware for 99% of
the drivers I've hacked on over the last 10 years.

btw, I realise you're trying to make a point, but you don't
need to send any further 900K tarballs to the list. An URL
would suffice.

		Dave

