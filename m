Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUHQN6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUHQN6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268248AbUHQN5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:57:52 -0400
Received: from main.gmane.org ([80.91.224.249]:38031 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268244AbUHQNxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:53:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: typo in laptop_mode.txt
Date: Tue, 17 Aug 2004 22:53:38 +0900
Message-ID: <cft2l3$s3t$1@sea.gmane.org>
References: <20040817104058.GA19921@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <20040817104058.GA19921@elf.ucw.cz>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> This patch is thanks to pavouk, please apply.
> 								Pavel
> 
> --- tmp/linux/Documentation/laptop-mode.txt	2004-08-15 19:14:52.000000000 +0200
> +++ linux/Documentation/laptop-mode.txt	2004-08-15 19:20:08.000000000 +0200
> @@ -249,7 +249,7 @@
>  # playing.
>  #READAHEAD=4096
>  
> -# Shall we remount journaled fs. with appropiate commit interval? (1=yes)
> +# Shall we remount journaled fs. with appropriate commit interval? (1=yes)
>  #DO_REMOUNTS=1
>  
>  # And shall we add the "noatime" option to that as well? (1=yes)
> 
See/repost it to:

http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/

Kalin.
-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

