Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269619AbUJLK6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbUJLK6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269614AbUJLKx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:53:57 -0400
Received: from main.gmane.org ([80.91.229.2]:39626 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269620AbUJLKvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:51:41 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: 2.6.9-rc4-mm1 Oops [2]
Date: Tue, 12 Oct 2004 19:51:32 +0900
Message-ID: <ckgcvl$t5r$1@sea.gmane.org>
References: <416B9517.7010708@blueyonder.co.uk> <877jpwi8cg.fsf@barad-dur.crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <877jpwi8cg.fsf@barad-dur.crans.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud wrote:
> Sid Boyce <sboyce@blueyonder.co.uk> disait dernièrement que :
> 
> 
>>This one on attempting to start firefox.
>>Regards
>>Sid.
> 
> 
> about the 2 reports you made about oopses, try this
> cd /path/to/your/kernel/source
> wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/nroken-out/optimize-profile-path-slightly.patch
> patch -R -p1 -i optimize-profile-path-slightly.patch
> 
> it should fix them

The long line above should be:
wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch

(s/nroken-out/broken-out/)

Cheers,
Kalin.
-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

