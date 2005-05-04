Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVEDNct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVEDNct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVEDNct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:32:49 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26444
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261819AbVEDNcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:32:41 -0400
Date: Wed, 4 May 2005 15:32:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: avoid infinite loop in x86_64 interrupt return
Message-ID: <20050504133251.GE3899@opteron.random>
References: <20050504050132.GA3899@opteron.random> <20050504132215.GF1174@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504132215.GF1174@wotan.suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 03:22:15PM +0200, Andi Kleen wrote:
> 
> It is already fixed in mainline. Actually I think it was a merging 
> problem I had actually fixed it before the last merge in my tree, but 
> some patches got lost :/

Ok thanks. I'm still not in sync with git so I didn't notice, I looked
into mercurial instead of git infact.
