Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVAEGJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVAEGJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 01:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVAEGJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 01:09:24 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:61034 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262259AbVAEGJT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 01:09:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PEGQoydnuKXcuaCjiCJA9bGAT7iLEEf3dI4r9ZvhVg42fWopJaad0pg7TitC5/saSTHwnwIgm7+BTS/Uf0N922ya5XJRjE0XC6MH3MXk2GXI/TwFUkFCdDIr+x84MUKpbWnx4isSJx8KSNpEm6CEsTDMPqHXd7T/UuoQYbpVP5Y=
Message-ID: <cce9e37e05010422096eb0a103@mail.gmail.com>
Date: Wed, 5 Jan 2005 06:09:19 +0000
From: Phil Lougher <phil.lougher@gmail.com>
Reply-To: Phil Lougher <phil.lougher@gmail.com>
To: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re: Linked list demo
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050105055150.5079.qmail@web60609.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050105055150.5079.qmail@web60609.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005 21:51:50 -0800 (PST), selvakumar nagendran
<kernelselva@yahoo.com> wrote:
> Hello,
>    I came to know from the book 'Linux kernel
> development' by Robert M Love that the kernel provides
> it's own linked list implementation. He has also given
> the relevant interfaces. But with that I am not able
> to understand the concepts. Can anyone send me a
> worked out example of the linked list possibly a
> simpler one?

Personally if you can't understand the concepts of the linked list
implementation from the book then you shouldn't really be programming
at the kernel level...  As far as examples of code goes, grep the
kernel source.  There's sure to be lots of examples there :-)

Phillip


> 
> Thanks,
> selva
> 
> __________________________________
> Do you Yahoo!?
> Meet the all-new My Yahoo! - Try it today!
> http://my.yahoo.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
