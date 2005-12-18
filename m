Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVLRQEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVLRQEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 11:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVLRQEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 11:04:46 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:38614 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965210AbVLRQEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 11:04:45 -0500
In-Reply-To: <20051218155737.GG23349@stusta.de>
References: <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218120900.GA23349@stusta.de> <2C3FD086-5582-4697-AB9F-578C80BA5811@comcast.net> <20051218155737.GG23349@stusta.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <673736C6-2049-4918-A5B9-85BB68138E02@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Sun, 18 Dec 2005 11:04:42 -0500
To: Adrian Bunk <bunk@stusta.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 18, 2005, at 10:57 AM, Adrian Bunk wrote:

> That's complete bullshit considering that we are talking about an
> i386-only patch.

Ok, ignore my rants, I wrongly assumed there is a drive to make all  
arches live with 4Kb! But if it's taking away the 8Kb option on i386  
please consider keeping the 8Kb option and making 4Kb default.

Parag
