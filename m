Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262825AbVAQSTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbVAQSTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVAQSQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:16:14 -0500
Received: from strutmasters.com ([161.58.166.59]:64781 "EHLO strutmasters.com")
	by vger.kernel.org with ESMTP id S262466AbVAQSMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:12:23 -0500
Message-ID: <41EC003B.7040606@strutmasters.com>
Date: Mon, 17 Jan 2005 13:13:15 -0500
From: Brian Henning <brian@strutmasters.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: smbfs in 2.6.8 SMP kernel
References: <41EBD4E8.70905@strutmasters.com> <Pine.LNX.4.61.0501171633140.20155@jjulnx.backbone.dif.dk>
In-Reply-To: <Pine.LNX.4.61.0501171633140.20155@jjulnx.backbone.dif.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> If I remember correctly there was some smbfs breakage a few releases back 
> - 2.6.8 sounds about right. I'd suggest you try a newer kernel like 2.6.10 
> or 2.6.11-rc1 and see if that works better.

No luck with smbfs in 2.6.10 with SMP either; however, I discovered the 
existence of CIFS (which I previously did not know about), and it 
appears to work smoothly in place of smbfs.

Thanks for the input, however; I'm sure it's better for me to be running 
a .10 instead of .8 anyhow.

Cheers,
~Brian

