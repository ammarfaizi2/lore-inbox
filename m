Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUEFVLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUEFVLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbUEFVLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:11:15 -0400
Received: from [81.219.144.6] ([81.219.144.6]:21771 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S263037AbUEFVLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:11:10 -0400
Message-ID: <409AA9EA.9020108@pointblue.com.pl>
Date: Thu, 06 May 2004 22:11:06 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Niccolo Rigacci <niccolo@rigacci.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2Gb file size limit on 2.4.24, LVM and ext3?
References: <20040506172152.GB17351@paros.rigacci.org>
In-Reply-To: <20040506172152.GB17351@paros.rigacci.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niccolo Rigacci wrote:

>- The partition is an ext3 over LVM, kernel 2.4.24. Debian Woody
>  (glibc-2.2.5-11.5). Pentium 4 2.80GHz.
>  
>
Ooops, sorry ;) can see it now.
afair you need at least 2.3 for large files. But I am not 100% sure.

--
GJ

