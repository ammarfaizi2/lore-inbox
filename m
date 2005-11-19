Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVKSKES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVKSKES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 05:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVKSKES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 05:04:18 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:39264 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750999AbVKSKER convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 05:04:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MFzAn5gMMh6WfBspFppG4VT2dmjx6sXuiTe/EKnIo54xwonROxxkUrDDg4ns9Ac2UkSN2cAWnd3w/qsRhTohhhivEaSx1l0MKYiDntQ4lD59XnWnmVIjzNx09KlRRwJZuMZCOKbFAa93YvtDTAYJDtZvZ1bCqf0T20mhUqCXUws=
Message-ID: <3aa654a40511190204kd19159bpcf043780dc71dbdc@mail.gmail.com>
Date: Sat, 19 Nov 2005 02:04:17 -0800
From: Avuton Olrich <avuton@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Kernel panic: Machine check exception
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1132394528.2829.4.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	 <1132394528.2829.4.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/05, Arjan van de Ven <arjan@infradead.org> wrote:
> does it happen without the nvidia binary module as well?

As (I think I said) the kernel wasn't tainted at the time, I had not
even started X yet, so to answer your question it does happen without
the nvidia binary module.

avuton

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
