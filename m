Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264373AbUGFUek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264373AbUGFUek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUGFUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:34:32 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:33173 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264571AbUGFUeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:34:06 -0400
To: Zack Brown <zbrown@tumblerings.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: problems getting SMP to work with vanilla 2.4.26
References: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com>
	<1089054464.15675.56.camel@dhcppc4>
	<20040706164839.GA1094@tumblerings.org>
	<1089133780.15675.468.camel@dhcppc4>
	<20040706171547.GB1453@tumblerings.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 06 Jul 2004 22:07:09 +0200
In-Reply-To: <20040706171547.GB1453@tumblerings.org> (Zack Brown's message
 of "Tue, 6 Jul 2004 10:15:47 -0700")
Message-ID: <m3pt78c32q.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Brown <zbrown@tumblerings.org> writes:

> No, I have 2.6.6 working pretty well now. I thought you just wanted a
> 2.4 success case. My dmesg output from 2.6.6 is appended.

Not sure if it matters, but I'm running Linux 2.4 on CUV4X-D (no onboard
LAN/SCSI) with no problems. I had to change (in BIOS setup) MPS 1.4 to
1.1 though (not sure if it's still needed).
-- 
Krzysztof Halasa
