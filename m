Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVALUZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVALUZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVALUZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:25:12 -0500
Received: from av10-2-sn2.hy.skanova.net ([81.228.8.182]:8836 "EHLO
	av10-2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261409AbVALUQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 15:16:05 -0500
Message-ID: <41E5856E.8070309@lanil.mine.nu>
Date: Wed, 12 Jan 2005 21:15:42 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [fuse-devel] Merging?
References: <loom.20041231T155940-548@post.gmane.org>	<E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu>	<E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112110109.6a21fae5.akpm@osdl.org>
In-Reply-To: <20050112110109.6a21fae5.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> heh.  What userspace filesystems have thus-far been developed, and what are
> people using them for?

Im using the LUFS bridge from time to time for nice access to remote 
filesystems over ssh. I also plan to use the bluetooth filesystem (btfs) 
as soon as I get my #/%" bluetooth adapter working again ;)

For a list of other more or less serious filesystems (as gmailfs) 
checkout http://fuse.sourceforge.net/filesystems.html

-- 
Regards,
Christian
