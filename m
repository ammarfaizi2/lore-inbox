Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSGNBDW>; Sat, 13 Jul 2002 21:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315517AbSGNBDV>; Sat, 13 Jul 2002 21:03:21 -0400
Received: from holomorphy.com ([66.224.33.161]:24227 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315513AbSGNBDV>;
	Sat, 13 Jul 2002 21:03:21 -0400
Date: Sat, 13 Jul 2002 18:05:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] BH removal text
Message-ID: <20020714010506.GW23693@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Wilcox <willy@debian.org>,
	Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020701050555.F29045@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 05:05:55AM +0100, Matthew Wilcox wrote:
> That doesn't mean that we shouldn't worry about the 38 files which use
> tq_timer, but they are almost all tty related and are therefore Hard ;-)

__global_cli(), timer_bh(), and bh_action() are crippling my machines.

Where do I start?


Cheers,
Bill
