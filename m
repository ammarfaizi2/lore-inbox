Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280290AbRJaQiV>; Wed, 31 Oct 2001 11:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280291AbRJaQiL>; Wed, 31 Oct 2001 11:38:11 -0500
Received: from sitar.i-cable.com ([210.80.60.11]:9108 "HELO sitar.i-cable.com")
	by vger.kernel.org with SMTP id <S280290AbRJaQh4>;
	Wed, 31 Oct 2001 11:37:56 -0500
Message-ID: <3BB7F3FC.1020909@rcn.com.hk>
Date: Mon, 01 Oct 2001 12:41:32 +0800
From: David Chow <davidchow@rcn.com.hk>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-GB; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: The old vm variables in /proc/sys/vm/
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I am porting my old code to the new kernels 2.4.12 , I find the a couple 
of variables including "freepages" in the kernel space are gone... how 
can I read these values in the kernel space? Also it is missing from 
/proc/sys/vm as well. Is there a new type of VM adopted in Linux? Thanks.

regards,

DC

