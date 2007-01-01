Return-Path: <linux-kernel-owner+w=401wt.eu-S932700AbXAAQsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbXAAQsc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbXAAQsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:48:32 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:2293 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755227AbXAAQsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:48:31 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: x86 instability with 2.6.1{8,9}
Date: Mon, 1 Jan 2007 16:48:55 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20070101160158.GA26547@deepthought>
In-Reply-To: <20070101160158.GA26547@deepthought>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701011648.55460.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 January 2007 16:01, Ken Moffat wrote:
>  Hi, I've been running an athlon64 in 64-bit mode without problems,
> up to and incluing 2.6.19.1.  A couple of weeks ago I decided to use
> it for testing x86 builds, since then it's been nothing but trouble
> in 32-bit mode.  It still works fine when I boot it in 64-bit mode.

Obviously papering over a severe bug, but why is it necessary for you to run a 
32bit kernel to test 32bit userspace? If your 64bit kernel is stable, use the 
IA32 emulation surely?

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
