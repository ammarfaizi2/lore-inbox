Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265114AbUE0Vqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbUE0Vqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 17:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUE0Vqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 17:46:32 -0400
Received: from main.gmane.org ([80.91.224.249]:3727 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265325AbUE0Vqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 17:46:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: nvidia not working on 2.6.6-bk5+ (x86-64) ?
Date: Thu, 27 May 2004 23:45:20 +0200
Message-ID: <c95njk$v62$1@sea.gmane.org>
References: <pan.2004.05.22.14.08.33.254151@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9ee3ea7.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.2) Gecko/20040426
X-Accept-Language: de, en
In-Reply-To: <pan.2004.05.22.14.08.33.254151@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the nvidia driver works fine on 2.6.6 but causes x to freeze on startup
> with 2.6.6-bk5+ (haven't tried -bk[1234]). the nv driver works. i first
> thought of the 4kstacks issue,but they are i386 only and the patch doesn't
> affect x86-64. any ideas what might break nvidia?

i have the same problem with 2.6.7-rc1. 2.6.6 works fine. (both kernels 
without any patches)


