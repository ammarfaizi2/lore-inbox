Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTKYFrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 00:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTKYFrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 00:47:13 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4105
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262015AbTKYFrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 00:47:12 -0500
Date: Mon, 24 Nov 2003 21:47:09 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: OOps! was: 2.6.0-test9-mm5
Message-ID: <20031125054709.GC1331@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031121121116.61db0160.akpm@osdl.org> <20031124225527.GB1343@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311241840380.8180@montezuma.fsmlabs.com> <20031124235807.GA1586@mis-mike-wstn.matchmail.com> <20031125003658.GA1342@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311242013270.1859@montezuma.fsmlabs.com> <20031125051018.GA1331@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311250033170.4230@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311250033170.4230@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 12:33:47AM -0500, Zwane Mwaikambo wrote:
> Indeed it looks PnPBIOS related, i'll await your other tests.

Ok, I'll get started compiling up some kernels.

Am I right in thinking that the pnpbios patches are in a series, where I
should revert 4, then 3, etc?

ta,

Mike
