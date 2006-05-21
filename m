Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWEUJ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWEUJ00 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWEUJ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:26:26 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:14549 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751514AbWEUJ0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:26:25 -0400
Message-ID: <4470323F.60303@dgreaves.com>
Date: Sun, 21 May 2006 10:26:23 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Liu haixiang <liu.haixiang@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops in kthread
References: <bf3792800605200537o2c9c8c47t9310321ae9205296@mail.gmail.com>	 <661de9470605200625x73929dbeme8fc487265ba66b7@mail.gmail.com> <bf3792800605202306v4b65bcadk51be97e4762b9d0b@mail.gmail.com>
In-Reply-To: <bf3792800605202306v4b65bcadk51be97e4762b9d0b@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Liu haixiang wrote:
> Hi Balbir,
>
> The FDMA is my coded module. And in my code, I didn't call kthread in
> my code but only call kthread_run once to create one kernel thread
> CallbackManager.
>
> So I don't understand why there is Oops from kthread and called by my
> CallbackManager.
>
> Can anybody explain to me when kthread will be called by the kernel?
> Then I can understand well why Oops happen.
Have you seen the kernel-newbies mailing list?
http://www.kernelnewbies.org/

It's for people who want to develop kernel code. It's full of people
asking (and answering) questions like this and you'll probably more
helpful answers (though you'll still probably need to provide source).

David

