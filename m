Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263239AbTECDCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 23:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTECDCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 23:02:33 -0400
Received: from zero.aec.at ([193.170.194.10]:64530 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263239AbTECDCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 23:02:33 -0400
Date: Sat, 3 May 2003 05:14:44 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Matt Bernstein <mb--lkml@dcs.qmul.ac.uk>, Andi Kleen <ak@muc.de>,
       elenstev@mesatop.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm4
Message-ID: <20030503031444.GA1657@averell>
References: <20030502020149.1ec3e54f.akpm@digeo.com> <1051905879.2166.34.camel@spc9.esa.lanl.gov> <20030502133405.57207c48.akpm@digeo.com> <1051908541.2166.40.camel@spc9.esa.lanl.gov> <20030502140508.02d13449.akpm@digeo.com> <1051910420.2166.55.camel@spc9.esa.lanl.gov> <Pine.LNX.4.55.0305030014130.1304@jester.mews> <20030502164159.4434e5f1.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502164159.4434e5f1.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 03, 2003 at 01:41:59AM +0200, Andrew Morton wrote:
> Andi, it died in the middle of modprobe->apply_alternatives()

BTW I just loaded an e100 module with BK-CVS current and there were no
problems.

-Andi
