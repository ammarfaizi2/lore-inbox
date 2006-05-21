Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWEUXDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWEUXDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWEUXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:03:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:34227 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751486AbWEUXDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:03:18 -0400
From: Neil Brown <neilb@suse.de>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
Date: Mon, 22 May 2006 09:02:51 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17520.61851.382933.12601@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
In-Reply-To: message from Pau Garcia i Quiles on Sunday May 21
References: <200605212131.47860.pgquiles@elpauer.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday May 21, pgquiles@elpauer.org wrote:
> 
> A short description would be "continuous system hibernation". Say you are 
> running Firefox, writing an e-mail in mutt and compiling the next X.org 
> release. The power goes off, your computer crashes or something happens and 
> you lose everything you were doing (yes, sadly you haved saved your e-mail as 
> a draft yet).

You need an editor that auto-saves regularly.  May I suggest emacs ;-)

One of my biggest grips about the current fad of web-based
interactions is that you get to use the editor built into your browser
rather than your editor of choice - and the editor built into firefox
is pretty lame....
Now if only firefox could embed a window from my running emacs ....

Or to put it another way:  you don't need to save the whole system
state: just save the bits you actually need to save.

NeilBrown
