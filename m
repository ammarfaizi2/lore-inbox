Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVCOQ5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVCOQ5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:57:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVCOQ5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:57:02 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:23169 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261486AbVCOQ4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:56:50 -0500
Date: Tue, 15 Mar 2005 16:56:48 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Dave Jones <davej@redhat.com>
Cc: Andrew Clayton <andrew@digital-domain.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm lockups since 2.6.11-bk2
In-Reply-To: <20050315165337.GG15531@redhat.com>
Message-ID: <Pine.LNX.4.58.0503151656250.443@skynet>
References: <Pine.LNX.4.58.0503151033110.22756@skynet> <20050315143629.GA27654@redhat.com>
 <Pine.LNX.4.58.0503151610560.443@skynet> <20050315165337.GG15531@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > the multi-bridge stuff is definitely broken as I've seen radeon and r128
>  > reports on it .. and it looks most like 2.6.11-bk2 broke things and I
>  > haven't merged anything until -bk7 ...
>
> Wait, -bk2 broke things ?   The big agp changes went into -bk3,
> so this seems odd.

sorry bk2-bk3 broke things... bk2 was okay..

Dave.
-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

