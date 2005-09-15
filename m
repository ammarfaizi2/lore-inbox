Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVIOTVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVIOTVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVIOTVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:21:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:30685 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964963AbVIOTVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:21:07 -0400
Message-ID: <4329C992.7030300@zytor.com>
Date: Thu, 15 Sep 2005 12:20:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4B2ZV-2dl-7@gated-at.bofh.it> <4HKbZ-Cx-37@gated-at.bofh.it> <4329BC43.7030406@v.loewis.de> <4329BCAB.1090106@zytor.com> <4329BFDC.70600@v.loewis.de>
In-Reply-To: <4329BFDC.70600@v.loewis.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin v. Löwis wrote:
> 
> We can do that now, or in five or ten years. I'm willing to wait that
> long, but I'm certain that more people will find the UTF-8 signature
> useful over time. It's the only sane way to get non-ASCII into script
> source in a consistent way.
> 

No.  The sane way is to just use UTF-8.

In five or ten years, by the time you've gotten your idiotic BOM mess to 
sort-of work, it will be completely pointless to have anything *but* 
UTF-8, and thus it's pointless.

Don't perpetuate the braindamage.

	-hpa
