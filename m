Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbUCXXvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 18:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbUCXXtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 18:49:53 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:60204 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262370AbUCXXtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 18:49:24 -0500
Message-ID: <40621E85.50503@blueyonder.co.uk>
Date: Wed, 24 Mar 2004 23:49:25 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Mar 2004 23:49:24.0608 (UTC) FILETIME=[A2EBE000:01C411FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Happe wrote:
On 2004-03-24, Andrew Morton <akpm@xxxxxxxx> wrote:
 >>/ -initramfs-search-for-init.patch/>
 >>/ -initramfs-search-for-init-zombie-fix.patch/
 >>/ +initramfs-search-for-init-orig.patch/
 >>
 >>/ Go back to the original, simple version of this patch./

 > 2.6.5-rc2-mm2 still hangs after:
 > VFS: mounted root (ext3 filesystem) readonly
 >  Freeing unused kernel memory: 140kB
 >
 > SysRq still works, what information would you need to solve that
 > problem?
 >
 > --Andreas
I am getting the same symptons on Acer 1501LCe laptop, Athlon 64,  
2.6.5-rc2 vanilla boots OK.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

