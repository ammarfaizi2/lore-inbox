Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270152AbTGNLqG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270096AbTGNLqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:46:06 -0400
Received: from holomorphy.com ([66.224.33.161]:28110 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270407AbTGNLo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:44:26 -0400
Date: Mon, 14 Jul 2003 05:00:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>, John Bradford <john@grabjohn.com>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: Linux v2.6.0-test1
Message-ID: <20030714120009.GH15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	John Bradford <john@grabjohn.com>, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <200307141150.h6EBoe1P000738@81-2-122-30.bradfords.org.uk> <20030714115313.GA21773@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714115313.GA21773@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:50:40PM +0100, John Bradford wrote:
>> Oh well, it just seems strange to be asking people to test
>> 2.6.0-root-my-box, without making the consequences a bit clearer.

On Mon, Jul 14, 2003 at 12:53:13PM +0100, Dave Jones wrote:
> If you don't have the time/energy to trawl linux-kernel, testing the
> many zillions of `sploits out there to see what works and what doesn't
> may be more fun. (Although most if not all should be failing, so it
> may also get boring very quickly). It'd be nice if someone like osdl
> could add such testing to nightly regression tests. Some of them may
> even be candidates for LTP perhaps ?

Some work has been done here, though I'm not sure how much; I'll try to
get the IBM people involved with it to chime in.


-- wli
