Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268076AbUHKOw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268076AbUHKOw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 10:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUHKOw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 10:52:56 -0400
Received: from levante.wiggy.net ([195.85.225.139]:64135 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S268076AbUHKOwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 10:52:54 -0400
Date: Wed, 11 Aug 2004 16:52:53 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Allow userspace do something special on overtemp
Message-ID: <20040811145253.GO32420@wiggy.net>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040811085326.GA11765@elf.ucw.cz> <1092215024.2816.8.camel@laptop.fenrus.com> <20040811090622.GC674@elf.ucw.cz> <1092235779.5028.93.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092235779.5028.93.camel@dhcppc4>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Len Brown wrote:
> Does /sbin/overtemp exist anyplace, or is this a proposal
> to create it?  What might it do?

Or why not use a netlink message for it?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
