Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTLDExS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 23:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLDExS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 23:53:18 -0500
Received: from ztxmail02.ztx.compaq.com ([161.114.1.206]:41232 "EHLO
	ztxmail02.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262805AbTLDExR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 23:53:17 -0500
Message-ID: <3FCEBE88.7030305@mailandnews.com>
Date: Thu, 04 Dec 2003 10:26:40 +0530
From: Raj <raju@mailandnews.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bloch, Jack" <Jack.Bloch@icn.siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 
References: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAA@stca204a.bus.sc.rolm.com>
In-Reply-To: <7A25937D23A1E64C8E93CB4A50509C2A0310EFAA@stca204a.bus.sc.rolm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bloch, Jack wrote:

>I try to open a non-existan device driver node file. The Kernel returns a
>value of -1 (expected). However, when I read the value of errno it contains
>a value of 29. A call to the perror functrion does print out the correct
>error message (a value of 2). Why does this happen?
>
>  
>
I tried this on a 2.6.0-test11 and it works fine. Pls specify your 
kernel version and attach the program if possible.

/Raj

