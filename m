Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVKOVws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVKOVws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbVKOVws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:52:48 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:16137 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932093AbVKOVwr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:52:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GkDClqHLNnWhy+LAjPMysvXTEILwcAjSdkMdXeKXc0Snx43pWRyyd5rhgGdkZItIFpZXHuunBPgo2WlicPmUzTpg6+G33W6cD/2PDLMZE6AmQPBVlBgC25ZnwaCvn1jbDUGo7n8XuSpiSZnNOvo2qCejC7KHjCQXCfEHFXGrIYY=
Message-ID: <3aa654a40511151352h5771060ekf1781b9d59b26b26@mail.gmail.com>
Date: Tue, 15 Nov 2005 13:52:46 -0800
From: Avuton Olrich <avuton@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051115210459.GA11363@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115210459.GA11363@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Greg KH <gregkh@suse.de> wrote:

>  - After two weeks a -rc1 kernel is released and now is possible to push only
>   patches that do not include new functionalities that could affect the
>    stability of the whole kernel.  Please note that a whole new driver (or

(functionalities is not a word, this maybe better)

- After two weeks a -rc1 kernel is released and it is only possible to
push patches which don't offer new features, or could affect the
stability of the kernel.

> 2.6.x.y -stable kernel tree
> ---------------------------
> Kernels with 4 digit versions are -stable kernels. They contain
> relativly small and critical fixes for security problems or significant
> regressions discovered in a given 2.6.x kernel.

relatively

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
