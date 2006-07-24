Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWGXNH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWGXNH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWGXNH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:07:29 -0400
Received: from sophia.inria.fr ([138.96.64.20]:23714 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S932139AbWGXNH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:07:28 -0400
Message-ID: <44C4C559.4090101@yahoo.fr>
Date: Mon, 24 Jul 2006 15:04:25 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
In-Reply-To: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (sophia.inria.fr [138.96.64.20]); Mon, 24 Jul 2006 15:04:26 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> 3) The ext4 code base will continue to mount older ext3 filesystems,

Everybody seems enthusiastic about this plan so I must have missed 
something, but
how will this compatibility prevent the ext4 code from looking like: 'if 
(ext4) { ... } else { /* ext3 */ ... }'?

Regards.

-- 
Guillaume

