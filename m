Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSJYS1R>; Fri, 25 Oct 2002 14:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSJYS1R>; Fri, 25 Oct 2002 14:27:17 -0400
Received: from dsl-213-023-039-129.arcor-ip.net ([213.23.39.129]:39337 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261529AbSJYS1R>;
	Fri, 25 Oct 2002 14:27:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.44-mm5
Date: Fri, 25 Oct 2002 20:34:21 +0200
X-Mailer: KMail [version 1.3.2]
References: <3DB8D94B.20D3D5BD@digeo.com>
In-Reply-To: <3DB8D94B.20D3D5BD@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1859Hr-0008PO-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 October 2002 07:40, Andrew Morton wrote:
> url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.44/2.5.44-mm5/
> 
> We seem to have found the dud patch.  Things should be a little
> more stable...
> 
> The CONFIG_PREEMPT+SMP problem I was having went away when gcc-2.95.3
> was used in place of 2.91.66.  Which is a bit of a problem because
> _someone_ has to keep an eye on 2.91.66 compatibility as long as it
> continues to be required for sparc builds.

Didn't davem say something about being ready to move to a more recent
compiler, or does my memory not serve correctly?

-- 
Daniel
