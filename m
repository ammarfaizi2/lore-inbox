Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVCNDIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVCNDIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVCNDH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:07:57 -0500
Received: from zeus.kernel.org ([204.152.189.113]:34229 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261699AbVCNDGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:06:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AygUZp+d8oBOxOxL/9q+5jb7ABZ3f0Qo3f6dUH8NcRjwAzQwBKnDChIjbpGxO11AtbeCq3gx2SP6/AOdkWz2CBDRfRPcgKonfdmDLDuDRukBVSZKSiNg2WwsBtBG6IEIBJLU6WTNh2aduSo7I9agrz/qsRkwn6L3iYBB/KE+QZw=
Message-ID: <9e47339105031318038d74da9@mail.gmail.com>
Date: Sun, 13 Mar 2005 21:03:28 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: nvidia fb licensing issue.
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org, adaplas@pol.net
In-Reply-To: <1110701914.6278.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050313042459.GF32494@redhat.com>
	 <20050312215936.513039a6.akpm@osdl.org>
	 <1110701914.6278.18.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All of the files in drivers/char/drm really should have an explicit
dual MIT/GPL license on them too. The DRM project has been taking
patches back into DRM from LKML without making it clear that DRM is
MIT licensed. It might be construed that doing this has made DRM GPL
without that being the intention.

-- 
Jon Smirl
jonsmirl@gmail.com
