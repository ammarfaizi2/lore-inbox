Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUH3HRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUH3HRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266703AbUH3HRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:17:03 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:38334 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S266117AbUH3HRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:17:01 -0400
Date: Mon, 30 Aug 2004 09:16:07 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Albert Cahalan <albert@users.sf.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040830071607.GB10950@k3.hellgate.ch>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube> <20040829214150.GA5060@k3.hellgate.ch> <1093822277.431.6919.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093822277.431.6919.camel@cube>
X-Operating-System: Linux 2.6.8 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 19:31:17 -0400, Albert Cahalan wrote:
> select data sources. Perhaps I should add a new
> /proc/*/basics file for the most popular items.

It shouldn't surprise that I am not keen on making any semantic changes
to /proc in order to help tools. nproc is a vastly superior interface.

Roger
