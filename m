Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUFBKYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUFBKYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUFBKYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:24:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:52679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261604AbUFBKYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:24:36 -0400
Date: Wed, 2 Jun 2004 03:23:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: wli@holomorphy.com, dominik.karall@gmx.net, linux-kernel@vger.kernel.org,
       James.Bottomley@SteelEye.com, Markus.Lidel@shadowconnect.com
Subject: Re: 2.6.7-rc2-mm1
Message-Id: <20040602032342.0ea631f6.akpm@osdl.org>
In-Reply-To: <20040602031842.60f48e35.pj@sgi.com>
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<200406011248.16303.dominik.karall@gmx.net>
	<20040601112418.GM2093@holomorphy.com>
	<20040602031842.60f48e35.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Just guessing, the problem is likely in the bk-scsi.patch, which seems
>  to be signed off by James Bottomley, and handled by or originated from
>  Markus Lidel and various others.  This is the only patch in Andrew's
>  2.6.7-rc2-mm1 that touches files matching drivers/scsi/sr*.

No, it's all due to my hamfisted attempt to resolve various bk conflicts. 
Don't choose "merge using sccs algorithm".  
