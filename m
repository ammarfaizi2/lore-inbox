Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbUAJHgI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 02:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265167AbUAJHgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 02:36:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:55777 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265165AbUAJHgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 02:36:06 -0500
Message-ID: <3FFFABBC.7030605@marcush.de>
Date: Sat, 10 Jan 2004 08:37:32 +0100
From: Marcus Hartig <marcus@marcush.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1 oopses
References: <3FFF33B2.1050707@marcush.de> <20040109152957.7d5a5559.akpm@osdl.org>
In-Reply-To: <20040109152957.7d5a5559.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:9d75d3da258886da80f58b1205b7baad
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

 > yup, sorry. You'll need to revert
 >
 > 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm1/broken-out/check-for-truncated-modules.patch

Yes, this solved it. Thanks, also for including the big ALSA 1.0.1 patch 
and the
nForce etherdeth driver in the mm kernels four the nForce users.


Marcus
