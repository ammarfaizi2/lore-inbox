Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbUKKHlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUKKHlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUKKHlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:41:32 -0500
Received: from [217.222.53.238] ([217.222.53.238]:65173 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S262182AbUKKHl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:41:29 -0500
Message-ID: <4193174D.6030706@gts.it>
Date: Thu, 11 Nov 2004 08:39:57 +0100
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm4
References: <20041109074909.3f287966.akpm@osdl.org>	 <200411091802.16386.s.rivoir@gts.it> <21d7e997041109151833ef1d90@mail.gmail.com>
In-Reply-To: <21d7e997041109151833ef1d90@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

>>A glxgears causes Xorg to get immediately out; nothing very notable in the
>>logs, except for

[...]
> Can you put up a dmesg as well? I think it might be something to do
> with DRM core in-kernel, but AGP and card driver as a module,

Yes, just FYI everything works fine if both options are built in-kernel 
and not as modules.

Bye.

-- 
Stefano RIVOIR

