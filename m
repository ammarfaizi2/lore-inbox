Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVCDPZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVCDPZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVCDPZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:25:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:23969 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262777AbVCDPZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:25:21 -0500
Message-ID: <42287E09.2080500@osdl.org>
Date: Fri, 04 Mar 2005 07:26:01 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Jon Smirl <jonsmirl@gmail.com>, "Antonino A. Daplas" <adaplas@hotpop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] [2.6 patch] drivers/video/: more cleanups
References: <20050303210119.GK4608@stusta.de> <9e47339105030314442a2b4e43@mail.gmail.com> <20050304113719.GE3992@stusta.de>
In-Reply-To: <20050304113719.GE3992@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Mar 03, 2005 at 05:44:30PM -0500, Jon Smirl wrote:
> 
>>On Thu, 3 Mar 2005 22:01:19 +0100, Adrian Bunk <bunk@stusta.de> wrote:
>>
>>>This patch contains cleanups including the following:
>>
>>Are you cleaning up all of that annoying trailing whitespace too? It
>>is always giving me problems on diffs.
> 
> 
> I'm not the maintainer, and such a cleanup might break all pending 
> patches.
> 
> Antonino, any opinions on such cleanups?

Should be a separate patch usually... if Antonio is OK with it
at all.

-- 
~Randy
