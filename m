Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVAROwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVAROwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVAROwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:52:40 -0500
Received: from mail6.hitachi.co.jp ([133.145.228.41]:12006 "EHLO
	mail6.hitachi.co.jp") by vger.kernel.org with ESMTP id S261307AbVAROwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:52:38 -0500
Message-ID: <41ED22AE.40809@sdl.hitachi.co.jp>
Date: Tue, 18 Jan 2005 23:52:30 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lkst-develop@lists.sourceforge.net
Subject: Re: [Lkst-develop] Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de> <41ECF0B6.30106@sdl.hitachi.co.jp> <20050118114632.GN43344@muc.de>
In-Reply-To: <20050118114632.GN43344@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andi Kleen wrote:
> On Tue, Jan 18, 2005 at 08:19:18PM +0900, Masami Hiramatsu wrote:
> 
>>Hello,
>>
>>I?m a developer of yet another kernel tracer, LKST. I and co-developers 
>>are very glad to hear that LTT was merged into -mm tree and to talk 
>>about the kernel tracer on this ML. Because we think that the kernel 
>>event tracer is useful to debug Linux systems, and to improve the kernel 
>>reliability.
> 
> 
> I haven't looked at your code, but I would suggest you also post
> for review it so that it can be evaluated in the same way
> as other more noisy proposals.
> 
> Perhaps Andrew can test both for some time in MM like he used
> to do for the various schedulers.

Thanks to your advice.
The latest release package of LKST baesd on linux-2.6.9 can be 
downloaded from
http://sourceforge.net/projects/lkst/

I'll release the LKST based on the latest kernel as soon as possible.

Regards,

-- 
Masami HIRAMATSU

Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp
