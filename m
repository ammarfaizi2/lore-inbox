Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVFWMZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVFWMZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVFWMZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:25:51 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:19279 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262286AbVFWMZo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:25:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bTlhJAW7e2jYu69XBNzCgIRUP3mU6p9JjjschjuM5IbjvA22Nh4iU0E6zbLcTDZ23iT7NWU8plvBZTqrntN/3aVTPi0tTrBgODFSKCia6sOc7O+vLRz8dMbG6mJxd/8u9KejRFV5Je5rSke9CHp6hcwRbofJ7Hk5KrNru0aUTOo=
Message-ID: <21d7e99705062305255b1ec58e@mail.gmail.com>
Date: Thu, 23 Jun 2005 22:25:43 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
In-Reply-To: <42B9E536.60704@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42B9E536.60704@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> jgarzik helper scripts, not in official git distribution:
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script
> 

Do you have some sort of magic bk-make-sum type util at all... 

For sending trees to Linus I used to run bk-make-sum and gcapatch and
then just throw my own stuff in the top of the mail ....

I'm being lazy I probably could write it myself, but bk-make-sum was a
very useful script for me...

Dave.
