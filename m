Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261976AbSIYNVg>; Wed, 25 Sep 2002 09:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261978AbSIYNVg>; Wed, 25 Sep 2002 09:21:36 -0400
Received: from dp.samba.org ([66.70.73.150]:60073 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261976AbSIYNVg>;
	Wed, 25 Sep 2002 09:21:36 -0400
Date: Wed, 25 Sep 2002 23:26:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] linux-2.5.38-mm2 cleanups
Message-ID: <20020925132636.GB2858@krispykreme>
References: <3D90E39C.5020107@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D90E39C.5020107@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I cc'd you, because the patch also moves the __cpu_to_node() 
> function from mmzone.h into topology.h, where it really belongs (as long as 
> the in-kernel topology stuff is there).  If there's some reason that 
> shouldn't be done, please yell at me! ;)

No problems from me :)

Anton
