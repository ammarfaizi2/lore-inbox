Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbVHUU6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbVHUU6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 16:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVHUU6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 16:58:23 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9416 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750938AbVHUU6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 16:58:22 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New maintainer needed for the Linux smb filesystem
References: <20050821143457.GA5726@stusta.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Aug 2005 22:26:54 +0200
In-Reply-To: <20050821143457.GA5726@stusta.de.suse.lists.linux.kernel>
Message-ID: <p73wtmf11f5.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> Since Urban Widmark was not active for some time, and I didn't have any 
> success trying to reach him, it seems we need a new maintainer for the 
> smb filesystem in the Linux kernel.
> 
> Is there anyone who both feels qualified and wants to become the new 
> maintainer?

One way would be to just deprecate and later drop it and let people
use cifs instead which is maintained. It only doesn't work with
some extremly old smb servers which are probably not very numerous
anymore.

-Andi
