Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTLGTM4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 14:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTLGTM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 14:12:56 -0500
Received: from holomorphy.com ([199.26.172.102]:30937 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264489AbTLGTMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 14:12:55 -0500
Date: Sun, 7 Dec 2003 11:12:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031207191248.GB8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com> <20031130164301.GK8039@holomorphy.com> <20031201073632.GQ8039@holomorphy.com> <20031207072803.GU8039@holomorphy.com> <Pine.LNX.4.58.0312071342590.1758@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312071342590.1758@montezuma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, William Lee Irwin III wrote:
>> Woops, those page sizes were a bit off. Come to think of it, so is
>> aio_setup_ring()...

On Sun, Dec 07, 2003 at 01:45:36PM -0500, Zwane Mwaikambo wrote:
> And here is a sync point, it gets DRI memory allocation/mapping code
> working. There are a few things which need to be ironed out wrt the radeon
> driver, but this is some good progress.
> Tested with the radeon DRI driver.

Terrific! I'll plop that and the various minimal fixes I've got atop -9
and ship it as -10 shortly.


-- wli
