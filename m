Return-Path: <linux-kernel-owner+w=401wt.eu-S1161072AbXAELum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161072AbXAELum (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 06:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161074AbXAELum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 06:50:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:48339 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161072AbXAELul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 06:50:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LnvvbhK4TaR830uTb8uHkOhDapbvFdRzMMMC+TFtLhYN5nTXa1YyGT0QfU97QLfJt8fiUoq0MR8JX2+ncdtD7GU7SueL5Iigj0rVc48M5LwEypgdeXA8zTxon94G5z0F6Dzya4cBeWvyWv4C5gH5t/pNiW93nytPu+xkVYgeroQ=
Message-ID: <8355959a0701050350o64e3af1en559ee26385b1e748@mail.gmail.com>
Date: Fri, 5 Jan 2007 17:20:39 +0530
From: Akula2 <akula2.shark@gmail.com>
To: Kristof.Provost@telenet.be
Subject: Re: Multi kernel tree support on the same distro?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <459D6239.7090601@telenet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
	 <459D6239.7090601@telenet.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not sure I understood your problem correctly.
> I see no reason to have two kernel versions on your host system. You can
> keep 2.6.x on the host, and compile a 2.4.x for the target. You don't
> need to run 2.4.x on your host.

I would like to have 2.4.x & 2.6.x on my host FC6 machine.
But am not sure whether FC6 would permit this or not?

> The TS-Kernel the website talks about is meant to run on the embedded
> target.
>
> Kristof

Yep, that's true. Here (TS-7300) am trying to port 2.6.18 kernel
(another story :))

~Akula2
