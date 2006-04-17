Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWDQWwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWDQWwH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWDQWwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:52:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:3255 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751373AbWDQWwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:52:06 -0400
Subject: Re: Unable to boot 2.6.17-rc1-git7 i386 hang after/during smp_init?
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <1145312755.5918.31.camel@keithlap>
References: <1145312755.5918.31.camel@keithlap>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Mon, 17 Apr 2006 15:52:04 -0700
Message-Id: <1145314324.5918.33.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 15:25 -0700, keith mannthey wrote:
> Hello All,
>   Something has broken for me since 2.6.16 was released.  I am not sure
> what has broken yet at but I wanted to post and see if anyone had any
> ideas. 
>   I am starting to look at do_pre_smp_initcalls....
> 
>   I am booting an i386 system with duel core processors (8 sockets with
> HT so 32 processors) and I am having a hang during boot with 2.6.16-rc1-
> git7 i386. x86_64 boots ok. I am going to move up to the current git
> form kernel.org as well today. 

Just booted rc1-git12 and it didn't hang so it looks like the problem
has already been fixed.  

Thanks,
  Keith Mannthey 
  LTC xSeries 

