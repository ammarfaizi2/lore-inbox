Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUDJStH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDJStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 14:49:07 -0400
Received: from colin2.muc.de ([193.149.48.15]:6404 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261530AbUDJStF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 14:49:05 -0400
Date: 10 Apr 2004 20:49:04 +0200
Date: Sat, 10 Apr 2004 20:49:04 +0200
From: Andi Kleen <ak@muc.de>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: amd64 questions
Message-ID: <20040410184904.GA12924@colin2.muc.de>
References: <1Ijzw-4ff-5@gated-at.bofh.it> <1Ijzv-4ff-3@gated-at.bofh.it> <1IntE-7wn-39@gated-at.bofh.it> <m3isgb69xx.fsf@averell.firstfloor.org> <407826DF.9030506@clanhk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407826DF.9030506@clanhk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So let me get this straight, we can't use LVM with AMD64 under the 2.6 

No, you completely misunderstood.

> line either?  Or we can if we use AMD64 [DM] libraries with a AMD64 
> kernel?  DM = Device Mapper right?

You can't use Device Mapper with 32bit user tools on a 64bit kernel
right now.

-Andi
