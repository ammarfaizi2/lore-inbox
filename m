Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTEKOyI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEKOyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:54:08 -0400
Received: from holomorphy.com ([66.224.33.161]:38059 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261688AbTEKOyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:54:06 -0400
Date: Sun, 11 May 2003 08:06:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
Message-ID: <20030511150641.GL8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@digeo.com
References: <3EB8E4CC.8010409@aitel.hist.no> <20030507.025626.10317747.davem@redhat.com> <20030507144100.GD8978@holomorphy.com> <20030507.064010.42794250.davem@redhat.com> <20030507215430.GA1109@hh.idb.hist.no> <20030508013854.GW8931@holomorphy.com> <20030508065440.GA1890@hh.idb.hist.no> <20030508080135.GK8978@holomorphy.com> <20030508100717.GN8978@holomorphy.com> <3EBA39B9.8040008@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBA39B9.8040008@aitel.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> 2.5.69-mm3 should suffice to test things now. If you can try that when
>> you get back I'd be much obliged.

On Thu, May 08, 2003 at 01:04:25PM +0200, Helge Hafting wrote:
> I'll do.
> It'll probably work, for a 2.5.69-mm2 without netfilter works fine.
> At least it stays up for hours where 2.5.69-mm2 with netfilter died
> in 15 minutes.

I think -mm3 only has the incomplete netfilter fix; you might want to
twiddle it to use davem's more complete fix instead.


-- wli
