Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWEPPks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWEPPks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWEPPks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:40:48 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:23285 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751270AbWEPPkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:40:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fHeyQoO53h1IfMOgp7Bj/pkkKuQSqlqSElZwPxkDwByktwasA7Yhs1hGwlXX1aZ2kKD+ZzNcTt6wdyXwzeAz/AACUPzxUz1MGDZ41wDtqAoDLn1AJriqQs5tcIYvIb03ThJvkHkl4oUlC9VQXfhDNqscZvwwI6UUOtHEJE3J2Zs=
Message-ID: <4469F275.6070804@gmail.com>
Date: Wed, 17 May 2006 00:40:37 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
CC: albertl@mail.com, Andi Kleen <ak@suse.de>,
       Marko Macek <Marko.Macek@gmx.net>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       =?ISO-8859-1?Q?Reinhard_Brandst=E4dter?= <r.brandstaedter@gmx.at>
Subject: Re: ASUS A8V Deluxe, x86_64
References: <8E8F647D7835334B985D069AE964A4F7028FDC0C@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDC0C@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
>> Fortier, can you please post full boot dmesg?
> 
> Sure.. Tonight when I`ll come back home.
> 
> BTW, you can use vincent instead :)
> 

Yeap, Vincent.  :-)

As bisecting patches is painful, let's postpone it until it can't be 
anymore.  If the boot log doesn't show much, I think I can insert codes 
disabling some of the new features such that full bisecting isn't necessary.

-- 
tejun
