Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWADHux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWADHux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWADHux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:50:53 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:37580 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751197AbWADHuw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:50:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pbIhhRcd1MravMtLSaDKn3IaJ90oRAtURVWn5ylLebWcL39Brq/w8ebtcuUwjnA/xAaykpgJUpg3yMu8gy6DjMhwCJ5WixLgslWhmIAq/DZK6PVO4OAsSYfsWX2ZHVMliqR/kXGT/09Iw9VH7jCKvI/FzqJJcdN7RdyGqoBacqo=
Message-ID: <9c21eeae0601032350q747e8733q7fa752aa3332a13c@mail.gmail.com>
Date: Tue, 3 Jan 2006 23:50:52 -0800
From: David Brown <dmlb2000@gmail.com>
To: =?ISO-2022-JP?Q?YOSHIFUJI_Hideaki_/_=1B=24B5HF=231QL=40=1B=28B?= 
	<yoshfuji@linux-ipv6.org>
Subject: Re: 2.6.15-rt1
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20060104.014301.113325512.yoshfuji@linux-ipv6.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0601031512m44c4a269ua2214528eaf90914@mail.gmail.com>
	 <20060103.202422.50699198.yoshfuji@linux-ipv6.org>
	 <9c21eeae0601032316l3259fbecle6a0b290ed244e12@mail.gmail.com>
	 <20060104.014301.113325512.yoshfuji@linux-ipv6.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have linux-2.6 git tree and I did something like this:
>
> $ cd linux-2.6
> $ patch -p1 < /tmp/patch-2.6.15-rt1
> hack, hack, hack...
> $ patch -p1 -R < /tmp/patch-2.6.15-rt1
> $ git reset
> $ git diff

Thanks again, this reminds me that I'm going to have to make a serious
effort to learn how to use git.

- David Brown
