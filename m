Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268987AbUJQAiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268987AbUJQAiT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJQAiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:38:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39616 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268987AbUJQAiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:38:15 -0400
Date: Sun, 17 Oct 2004 01:38:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Panos Polychronis <maxsoft@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6.9-rcX & -final warnings
Message-ID: <20041017003813.GG23987@parcelfarce.linux.theplanet.co.uk>
References: <20041016231605.5D7DF2B2B86@ws5-7.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016231605.5D7DF2B2B86@ws5-7.us4.outblaze.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 07:16:05AM +0800, Panos Polychronis wrote:
> Date: 2004-10-15 (21:30):   0w,0e    11w,0e  1950w,0e  (2.6.9-final)
> 
> what will happen with all those warnings ?

They will be dealt with.  Note that quite a few of them already are outside
of Linus' tree, so it's a matter of post-2.6.9 merges.
