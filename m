Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269726AbUJMOdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269726AbUJMOdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269727AbUJMOdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:33:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63390 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269726AbUJMObQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:31:16 -0400
Message-ID: <416D3C16.7010603@in.ibm.com>
Date: Wed, 13 Oct 2004 20:00:46 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-mm1: CRASH_DUMP compile error with PROC_FS=n
References: <20041011032502.299dc88d.akpm@osdl.org> <20041012184910.GD18579@stusta.de>
In-Reply-To: <20041012184910.GD18579@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
> 
>>...
>>All 741 patches
>>...
>>crashdump-elf-format-dump-file-access.patch
>>  crashdump: ELF format dump file access
>>...
> 
> 
> 
> This fails to compile with CONFIG_PROC_FS=n:

I will make a patch for this real soon and send it across. 
Thanks a lot!

Regards, Hari
