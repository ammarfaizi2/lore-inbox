Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269038AbUJQDkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269038AbUJQDkc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269039AbUJQDkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:40:31 -0400
Received: from holomorphy.com ([207.189.100.168]:14997 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269038AbUJQDk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:40:27 -0400
Date: Sat, 16 Oct 2004 20:40:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: christophpfister@bluemail.ch,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: failure in /mm/memory.c
Message-ID: <20041017034018.GX5607@holomorphy.com>
References: <412EB75E00164E05@mssazhh-int.msg.bluewin.ch> <20041016120911.GW5607@holomorphy.com> <1097980417.13428.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097980417.13428.17.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 12:32:35PM +0100, christophpfister@bluemail.ch wrote:
>>> i found a failure in function remap_pte_range in memory.c

On Sad, 2004-10-16 at 13:09, William Lee Irwin III wrote:
[...]

On Sun, Oct 17, 2004 at 03:33:39AM +0100, Alan Cox wrote:
> I think the bug is in the comment not the code !

I suppose the comment is a bit off, sure. I'll send an update atop the
remap_pfn_range() patch series akpm has in -mm to correct it.


-- wli
