Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbULYJJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbULYJJn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 04:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbULYJJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 04:09:43 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:5045 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261435AbULYJJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 04:09:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=gjFkZQ+tHSF3x7sM2KFiiTAAj+qsj4bCX8U6Zk5Px1T0jEdSqvFCjfRCmlX6YpHcvCd52oHItmKhuoMg5/1H5zq3dmdODwrI68WCcGfEu44tV+rRGfkj9MrEXqrlhjGGz1FmKtW5dyn9+YUZNn4pcOKXtn1HBxbIAMxzPC9CzN4=
Message-ID: <31f2b71904122501096a8b787@mail.gmail.com>
Date: Sat, 25 Dec 2004 09:09:39 +0000
From: Graeme T Ford <gtford@gmail.com>
Reply-To: Graeme T Ford <gtford@gmail.com>
To: linux lover <linux.lover2004@gmail.com>
Subject: Re: Understanding how kernel functions works and adding new one
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <72c6e3790412242020482eadbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <72c6e3790412242020482eadbe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take a look at:

http://www.kernelhacking.org/docs/kernelhacking-HOWTO/index.html

and

http://www.linuxhq.com/lkprogram.html

First is a basic intro, the latter contains some good information to
get you started.

You might also find just looking at random .c files in the driver
source directory helpful, to see how it's been done there.

Lastly, I've noticed you've been asking some questions over the past
few days which are easily answered by a simple Google search - may I
suggest that as a first point of call in future. You'd probably learn
a lot more by searching for stuff yourself.

Regards (and Merry Christmas),

Graeme.


On Sat, 25 Dec 2004 09:50:23 +0530, linux lover
<linux.lover2004@gmail.com> wrote:
> Hello ,
>          I want to know what things are require me to add my own
> function in kernel through modules?
>           Actually i  have 2 questions in my mind
>        1) Is it possible to write own user defined function in kernel
> modules and get in laoded in kernel and allow kernel to use it?
>        2) Is it possible to add my own function program in C file to
> kernel and allow my kernel module to use it?
>        I want to add own function not any system call(Am i
> misunderstanding between syscall and new function call in kernel?)
>          Can anybody correct me in above approaches?Also give me steps
> to do that adding functions in kernel/kernel module?
> Thanks in advance.
> regards,
> linux.lover
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
