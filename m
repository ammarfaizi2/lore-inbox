Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbSKTNvn>; Wed, 20 Nov 2002 08:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbSKTNvn>; Wed, 20 Nov 2002 08:51:43 -0500
Received: from 209-166-240-202.cust.walrus.com.240.166.209.in-addr.arpa ([209.166.240.202]:47316
	"EHLO ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id <S266116AbSKTNvm>; Wed, 20 Nov 2002 08:51:42 -0500
Date: Wed, 20 Nov 2002 08:58:38 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: RFC - new raid superblock layout for md driver
Message-ID: <20021120085838.A9206@ti19>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Wed, Nov 20, 2002 at 03:09:18PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 03:09:18PM +1100, Neil Brown wrote:
>     u32  feature_map     /* bit map of extra features in superblock */

Perhaps compat/incompat feature flags, like ext[23]?

Also, journal information, such as a journal UUID?

Regards,

	Bill Rugolsky

