Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVI2PSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVI2PSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbVI2PSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:18:53 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:62444 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932193AbVI2PSw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:18:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gXYT3mKMFZZpdrfS5YMQzWgrD8/0xnEXHIdq79II60PMWf7Mujk2TNuvMFlgiAZdm+aEV3wlc4aCn+PFpo1VGhQPLTlq7JL3DM+pYmCJTHhNBmLucW7gqF2jEiw2VuJpTOnPEPpufN54HFUyAfMdvDWmAUiCyXNNg2AedEjn3yo=
Message-ID: <3e1162e605092908187e181936@mail.gmail.com>
Date: Thu, 29 Sep 2005 08:18:49 -0700
From: David Leimbach <leimy2k@gmail.com>
Reply-To: David Leimbach <leimy2k@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
In-Reply-To: <433BC9E9.6050907@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <433BC9E9.6050907@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/05, Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Just updated my KHGtG to include the latest goodies available in
> git-core, the Linux kernel standard SCM tool:
>
>         http://linux.yyz.us/git-howto.html

Can you update the date on that page to reflect your latest updates? 
I was digging around with git yesterday and had a few surprises...
like checking out the kernel and being told I modified a bunch of
files I never touched.

- Dave
