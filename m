Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSGYQO1>; Thu, 25 Jul 2002 12:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSGYQO1>; Thu, 25 Jul 2002 12:14:27 -0400
Received: from 209-87-236-21.ottawa.storm.ca ([209.87.236.21]:57231 "EHLO
	xandros.com") by vger.kernel.org with ESMTP id <S314938AbSGYQO1>;
	Thu, 25 Jul 2002 12:14:27 -0400
Message-ID: <3D4024A3.6030401@xandros.com>
Date: Thu, 25 Jul 2002 12:17:39 -0400
From: Pat Suwalski <pats@xandros.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020610 Debian/1.0.0-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modversion clarification.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to figure out exactly what modversions.h does.

Speaking to two seperate developers who have worked on the 2.2 kernel, 
having modversion on in the kernel config causes module versioning to be 
extremely strict, with sort of 'keys' that only allow it to be run on 
the exact kernel config a module was built on.

According to several places in the 2.4.x documentation, it is the exact 
opposite, and allows for large freedom to exchange modules between kernels.

Could someone please clarify for me?

Thanks,
--Pat

