Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUGaKGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUGaKGu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 06:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUGaKGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 06:06:49 -0400
Received: from holomorphy.com ([207.189.100.168]:64671 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267935AbUGaKGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 06:06:48 -0400
Date: Sat, 31 Jul 2004 03:06:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eric Anholt <eta@lclark.edu>
Cc: arjanv@redhat.com, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org, DRI <dri-devel@lists.sourceforge.net>
Subject: Re: drm - first steps towards 64-bit correctness..
Message-ID: <20040731100641.GA2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Eric Anholt <eta@lclark.edu>, arjanv@redhat.com,
	Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
	DRI <dri-devel@lists.sourceforge.net>
References: <Pine.LNX.4.58.0407310940540.6368@skynet> <1091266345.425.34.camel@leguin> <1091267687.2819.3.camel@laptop.fenrus.com> <1091267836.425.46.camel@leguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091267836.425.46.camel@leguin>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 02:54, Arjan van de Ven wrote:
>> can you explain why u32 would be outlawed? Surely it's trivial to do a
>> typedef for u32 on BSD for drm ??

On Sat, Jul 31, 2004 at 02:57:17AM -0700, Eric Anholt wrote:
> If there are nice standard types (uint32_t or u_int32_t, can't remember
> which at the moment, I mentioned it in an email some time ago) out there
> already that linux has too, why not use those?

uint*_t. ISTR something about Linux' usage predating standard type
names for the things.

I have much more serious issues with other naming conventions to get
worked up about this one. In general I don't mind ones that are less
verbose than the standard.


-- wli
