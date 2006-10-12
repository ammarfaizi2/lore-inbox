Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932529AbWJLPCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWJLPCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbWJLPCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:02:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57519 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932529AbWJLPCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:02:46 -0400
Subject: Re: The Future of ReiserFS development
From: Lee Revell <rlrevell@joe-job.com>
To: roland <devzero@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <005a01c6edd9$7cfb7be0$962e8d52@aldipc>
References: <005a01c6edd9$7cfb7be0$962e8d52@aldipc>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 11:03:40 -0400
Message-Id: <1160665420.24931.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 10:36 +0200, roland wrote:
> >> What is the plan? Could i
> >> migrate from reiserfs to another journaling filesystem?
> >
> >Of course: Simply backup, mkfs and restore!
> 
> not that simple if you have hundreds of thousands or even millions of small 
> files !
> reiserfs is quite efficient in storing small files.
> don`t know if there is anyfilesystem which is as efficient with this.....

I thought reiserfs (aka reiser3) was in deep maintainence mode anyway?
Why do you need to migrate away from it?

Reiser4 however is another story...

Lee

