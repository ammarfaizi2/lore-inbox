Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269671AbUISEHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269671AbUISEHN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 00:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269677AbUISEHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 00:07:13 -0400
Received: from undl.funcitec.rct-sc.br ([200.135.30.197]:3970 "HELO
	mail.undl.org.br") by vger.kernel.org with SMTP id S269671AbUISEHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 00:07:09 -0400
Message-ID: <414D05A8.3080208@undl.org.br>
Date: Sun, 19 Sep 2004 01:06:00 -0300
From: Carlos Eduardo Medaglia Dyonisio <medaglia@undl.org.br>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-bk4 Unknown symbol __VMALLOC_RESERVE
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAvNyRn41Uu0yDWG5tHRPqegEAAAAA@syphir.sytes.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAvNyRn41Uu0yDWG5tHRPqegEAAAAA@syphir.sytes.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

C.Y.M. wrote:
> After testing 2.6.9-rc2-bk4 today, I am getting the following error when I
> attempt to load my Nvidia module:
> 
> Sep 18 15:31:36 poseidon kernel: nvidia: module license 'NVIDIA' taints
> kernel.
> Sep 18 15:31:36 poseidon kernel: nvidia: Unknown symbol __VMALLOC_RESERVE

I've had this problem too. Try to use bk3. It is working for me. :)

Regards,
Cadu
