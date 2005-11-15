Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVKOAee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVKOAee (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVKOAee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:34:34 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:64229 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S932216AbVKOAed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:34:33 -0500
Message-ID: <43792D16.2020404@g-house.de>
Date: Tue, 15 Nov 2005 01:34:30 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2: no .config.old any more?
References: <43792372.2010409@g-house.de> <20051114160502.6ef9d1e8.akpm@osdl.org>
In-Reply-To: <20051114160502.6ef9d1e8.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton schrieb:
> 
> A proper patch (which maybe does an lstat+special-stuff) would be nice.

hm, sorry, but i don't think i can help out here.

> But that particular diff only appears in the -mm rollup when I'm carrying
> other patches against confdata.c, which rarely happens.  So it'll go away
> again.

thank you.

Christian.
-- 
BOFH excuse #74:

You're out of memory
