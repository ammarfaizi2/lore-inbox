Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTDNTcy (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTDNTcy (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:32:54 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:7082 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263700AbTDNTcw (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 15:32:52 -0400
Date: Mon, 14 Apr 2003 21:44:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: top stack (l)users for 2.5.67
Message-ID: <20030414194442.GF12740@wohnheim.fh-wedel.de>
References: <20030414173047.GJ10347@wohnheim.fh-wedel.de> <20030414123810.7d61ece6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030414123810.7d61ece6.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 April 2003 12:38:10 -0700, Randy.Dunlap wrote:
> On Mon, 14 Apr 2003 19:30:47 +0200 Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> 
> | 0xc05e2733 ida_ioctl:                                    sub    $0x54c,%esp
> 
> patch posted 2003.APR.03 (on lkml); Steve Cameron saw it...
> 
> | 0xc0fb00e3 device_new_if:                                sub    $0x520,%esp
> 
> patch posted 2003.APR.03 (on linux-net);
> no reply from Nenad Corbic (ncorbic@sangoma.com)

Hm, all these stack reduction patches are relevant to -je as well.
Could I have a copy of those two?

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon
