Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVD3M5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVD3M5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 08:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVD3M5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 08:57:42 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:63069 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261213AbVD3M5k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 08:57:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R5nBDGqlov04Bb+8EbJCTOcjww7cdKP2Gm0uwwo9ODw/gjzoGrMNNtzmyOXvDZbStb3aQXWtUn75p/wmorr9q3bAV/J1ZQ/9gyvQgut/mPwNtWVH14cqBY4G/DmSl9kZrDMUx7DHHkBqEFsU82NNjbj3l8kJY9II2NemDxKX+vg=
Message-ID: <fe726f4e05043005573b1e922d@mail.gmail.com>
Date: Sat, 30 Apr 2005 14:57:40 +0200
From: Carlos Martin <carlosmn@gmail.com>
Reply-To: Carlos Martin <carlosmn@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc3-mm1 doesn't boot
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050430124603.GA3528@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050429231653.32d2f091.akpm@osdl.org>
	 <20050430124603.GA3528@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/05, Adrian Bunk <bunk@stusta.de> wrote:
> 2.6.12-rc3-mm1 doesn't boot on my computer.
> 
> Comparing the point where booting stops with a boot from a working
> kernel, the first line that isn't displayed is the line where init says
> it's starting.
 I got the same.
> Ctrl-Alt-Del at this point reboots my computer.
> 
> Both 2.6.12-rc3 and 2.6.12-rc2-mm3 do boot.
> 
> My computer is a cheap desktop computer with one 1,8 GHz Athlon CPU.
 Mine's a P4 2.8GH
z
> I know what a binary search is, but since I currently need my computer
> and I can't do 10 compile and reboot cycles today any hints which
> patches are suspect of being guilty is appreciated.
 I'll see if I can pinpoint some patch, but it'll take some time.

   cmn
-- 
Carlos Martín         http://www.cmartin.tk   http://rpgscript.berlios.de

"I'll wager it's the most extraordinary thing to happen round here
since Queen Elizabeth's handmaid got hit by lightning and sprouted a
beard"
     -- T. C. Boyle, "Water Music"
