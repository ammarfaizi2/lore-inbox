Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271410AbTG2Mde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271413AbTG2Mde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:33:34 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:35794 "EHLO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S271410AbTG2Mde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:33:34 -0400
Date: Tue, 29 Jul 2003 21:33:30 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
Subject: Re: raid5 autoselecting a slower checksum function
Message-Id: <20030729213330.684b43ff.bharada@coral.ocn.ne.jp>
In-Reply-To: <20030728205438.GI32673@louise.pinerecords.com>
References: <Pine.GSO.4.44.0307281811290.13144-100000@math.ut.ee>
	<20030729003046.15975639.bharada@coral.ocn.ne.jp>
	<20030728205438.GI32673@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 22:54:38 +0200
Tomas Szepe <szepe@pinerecords.com> wrote:

> Fair enough, but wouldn't it be more appropriate if the kernel printed
> a message like "SSE present, good.  No need to try the other checksumming
> methods" in this case?

As I recall, someone actually posted a small patch to indicate that - I assume
it got dropped or lost. Certainly, the current message is rather confusing.

