Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965262AbVKBVfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbVKBVfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbVKBVfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:35:03 -0500
Received: from ns1.ptt.yu ([212.62.32.1]:47275 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id S965262AbVKBVfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:35:01 -0500
Date: Wed, 2 Nov 2005 21:38:14 +0100
From: Predrag Ivanovic <predivan@ptt.yu>
To: ck@vds.kolivas.org
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, wfg@mail.ustc.edu.cn
Subject: Re: [ck] 2.6.14-ck1
Message-Id: <20051102213814.15724994.predivan@ptt.yu>
In-Reply-To: <200510282118.11704.kernel@kolivas.org>
References: <200510282118.11704.kernel@kolivas.org>
Reply-To: ck@vds.kolivas.org
Organization: Random Violence
X-Mailer: Sylpheed version 2.1.5+svn (GTK+ 2.6.8; i686-pc-linux-gnu)
X-Operating-System: Crux-2.1
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2005 21:18:09 +1000
Con Kolivas wrote:

<snip> 
> Changes:
> 
> Added:
> +adaptive-readahead-4.patch
> We Fengguang's adaptive readahead patch. Please test and report
> experiences - Wu has been cc'ed on this email, please keep him cc'ed
> for reports.
> 
Con,any recommended value for /proc/sys/kernel/readahead_ratio,
or is it automagicly set?It's value is 0 ATM. 
 
Great work with ck.BTW :-)

Pedja
--
 Data is a lot like humans: It is born. Matures. Gets married to other
data, divorced. Gets old. One thing that it doesn't do is die. It has
to be killed. -- Arthur Miller
