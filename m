Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVKZW10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKZW10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 17:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVKZW1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 17:27:25 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:33892 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750768AbVKZW1Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 17:27:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dXJHdQu4Znpax404ozK39/x5wOmo6j/JhbGEoDSG1lGT+uSDhGhpLXq9Pab7DYrxIMucWTYRbB+ce1pYqRSoYoU3bBxnc6ot7jQiTs1k8ze1trPtjQCYumV+aSKl8dGj1mF3HqZc7zVT4TINOoPvwZUCqq3sT/zyzwpaj4/yfkc=
Message-ID: <9c21eeae0511261427ld8375bfi1c838b56cab426fb@mail.gmail.com>
Date: Sat, 26 Nov 2005 14:27:24 -0800
From: David Brown <dmlb2000@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.14.tar.bz2 permissions
In-Reply-To: <200511262319.15042.norbert-kernel@hipersonik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com>
	 <9c21eeae0511261358v723419f2g853bddc839038996@mail.gmail.com>
	 <200511262319.15042.norbert-kernel@hipersonik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The rights on the files should be sufficient for the compiler to go through
> the tree and compile the kernel for you. If it bothers you, you can just run
> chmod -R to correct it.

Yeah but it took me a couple of weeks and a few updates of my kernel
to find it...
Some one could have broke in and changed things without being root and
I wouldn't have noticed it.

> I guess that it will not be corrected.

I just find it odd that I now have to check permissions all over the
place to make sure everything is safe.

- David Brown
