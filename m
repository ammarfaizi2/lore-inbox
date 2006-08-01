Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161323AbWHAHcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161323AbWHAHcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161337AbWHAHcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:32:18 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:57835 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161037AbWHAHcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:32:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UoXhm//4IJlSfRc3AZRAqXQSTOa8wiUWvZTFXQe4o9wkZW41aGUt/x8RAFtcUEzJGolPY5mIikCQlKCQeVAcxwUSll47EouNIzaTRyIivFJJ1/NIhuCg2gNJgYpHIM8zxVzXxIVP1bUoRLCfrTpAsAoCIxyXtm/5pc6I064ucwo=
Message-ID: <44CF038B.50809@gmail.com>
Date: Tue, 01 Aug 2006 16:32:27 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: alan@lxorguk.ukuu.org.uk, jamagallon@ono.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [2.6.18-rc2-mm1] libata ate one PATA channel
References: <20060728134550.030a0eb8@werewolf.auna.net>	<44CD0E55.4020206@gmail.com>	<20060731172452.76a1b6bd@werewolf.auna.net>	<44CE2908.8080502@gmail.com>	<1154363489.7230.61.camel@localhost.localdomain>	<20060731165011.GA6659@htj.dyndns.org> <20060731232243.65468eec.akpm@osdl.org>
In-Reply-To: <20060731232243.65468eec.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 1 Aug 2006 01:50:11 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>>> It'll be easier just to work outside the -mm tree with all this
>>> continued in/out random breakage if people are just going to say "drop
>>> xyz patch" rather than actually specifying *what is actually wrong* and
>>> getting me to fix the merge (Tejun that last one sentence is a hint ;))
>> Okay, took the hint.  Magallon, can you please try the following
>> patch?
> 
> Gee that's a big scary patch.  Is it considered ready for -mm?  (bearing in
> mind -mm's exacting quality standards (heh, I kill me)).
> 

It's still a bit broken.  I'll follow up with better patches later today 
(hopefully :)

Thanks.

-- 
tejun
