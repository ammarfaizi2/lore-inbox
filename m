Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVBOWqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVBOWqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVBOWo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:44:27 -0500
Received: from mail.tyan.com ([66.122.195.4]:13578 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261922AbVBOWnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:43:46 -0500
Message-ID: <3174569B9743D511922F00A0C94314230808586B@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: X86_64 kernel support MAX memory.
Date: Tue, 15 Feb 2005 14:57:14 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It passed the memtest86+ 3.1a

No oops dump, it just restart the system.

YH 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Tuesday, February 15, 2005 2:42 PM
> To: YhLu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: X86_64 kernel support MAX memory.
> 
> On Tue, Feb 15, 2005 at 02:34:17PM -0800, YhLu wrote:
> > If only use 64G RAM, it works well.
> 
> Are you sure the RAM is not broken?  The more you have of it 
> the more likely one DIMM is bad.
> 
> Otherwise debug it. What's the oops dump?
> 
> -Andi
> 
