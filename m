Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbUADQFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbUADQFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:05:12 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:64977 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265708AbUADQEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:04:06 -0500
Date: Sun, 04 Jan 2004 08:04:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: DaMouse Networks <damouse@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-mjb1
Message-ID: <6220000.1073232239@[10.10.2.4]>
In-Reply-To: <20040104113630.78a94dcd@EozVul.WORKGROUP>
References: <20040104113630.78a94dcd@EozVul.WORKGROUP>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm just wondering how the HT schedular merge is coming? I'm interesting 
> in getting a better/new one for some testing so I wondered how it was 
> coming along with it being ported to 2.6.1-rc1.

Ingo's scheduler crashes on boot for me. I haven't tried Nick's stuff in
a while, but it's pretty extensive, and comes with a lot of stuff that'll
conflict with what I currently have, so not much fun to merge probably.

Does Nick's stuff work for you?

M.

