Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTDUMre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 08:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTDUMre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 08:47:34 -0400
Received: from x101-201-233-dhcp.reshalls.umn.edu ([128.101.201.233]:18859
	"EHLO minerva") by vger.kernel.org with ESMTP id S263848AbTDUMre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 08:47:34 -0400
Date: Mon, 21 Apr 2003 07:59:30 -0500
From: Matt Reppert <arashi@yomerashi.yi.org>
To: linux-kernel@vger.kernel.org
Subject: Re: sooner 2.4.21-pre8
Message-Id: <20030421075930.5b776387.arashi@yomerashi.yi.org>
In-Reply-To: <200304210724.32437.brian@mdrx.com>
References: <Pine.LNX.4.55.0304210823230.944@boston.corp.fedex.com>
	<200304202352.06128.brian@mdrx.com>
	<20030421010743.5309f585.arashi@yomerashi.yi.org>
	<200304210724.32437.brian@mdrx.com>
Organization: Yomerashi
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-message-flag: : This mail sent from host minerva, please respond.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003 07:24:32 -0500
Brian Jackson <brian@mdrx.com> wrote:

> I meant the -bkN snapshots, but I can only seem to find them for Linus' tree. 

Oh, yes. Those are only being generated for 2.5, yes, at least they way you're
thinking. You may want to look at this though:

http://www.XX.kernel.org/pub/linux/kernel/v2.4/testing/cset/

(Doing appropriate substitution for XX with country codes of course.) This
does seem to have a gzipped patch from the latest -pre to the BK tree as of
some time.

Matt
