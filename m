Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUIGVC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUIGVC2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268634AbUIGVC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:02:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:36081 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268609AbUIGVCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:02:03 -0400
Message-ID: <413E21B5.9040401@us.ibm.com>
Date: Tue, 07 Sep 2004 14:01:41 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <Pine.LNX.4.58.0409040107190.18417@skynet>	 <a728f9f904090317547ca21c15@mail.gmail.com>	 <Pine.LNX.4.58.0409040158400.25475@skynet>	 <9e4733910409032051717b28c0@mail.gmail.com>	 <Pine.LNX.4.58.0409040548490.25475@skynet>	 <9e47339104090323047b75dbb2@mail.gmail.com>	 <2191E8A1-FE89-11D8-BFDA-000A95F07A7A@fs.ei.tum.de> <9e47339104090408598631026@mail.gmail.com>
In-Reply-To: <9e47339104090408598631026@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> I'm a little concerned that we are doing a lot of work to support a
> few people (<100) using DRM on BSD. I suspicious that it is a very
> small number since we get close to zero complaints about BSD even
> though we break it continuously.

I think the difference may be that BSD users don't update out-of-tree 
kernel modules like Linux users do.  Because of that, they never see the 
breakage.

