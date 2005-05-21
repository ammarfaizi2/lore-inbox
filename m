Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVEUIHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVEUIHv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 04:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVEUIHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 04:07:50 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:27274 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261695AbVEUIHp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 04:07:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G8zVX+JDqf6tpdp2UyiUUjrVYztrCFY3GWvMh7LQcH23Fh/BwEElt0VYsY7IWhjr0ZhF/+CUxr8XWFZ7TKL9uP9uXGJRmfjQteZGqSJaJxuM1o3AZCA9gyLJ0tIsX7ll7YbUoVE8TR6/WoGU66rhSF2D1+X7X6PIRFEml82Qsio=
Message-ID: <9cde8bff05052101079a51fe6@mail.gmail.com>
Date: Sat, 21 May 2005 01:07:43 -0700
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3 of 4] ima: Linux Security Module implementation
Cc: Reiner Sailer <sailer@watson.ibm.com>, toml@us.ibm.com, emilyr@us.ibm.com,
       linux-kernel@vger.kernel.org, kylene@us.ibm.com,
       linux-security-module@wirex.com
In-Reply-To: <20050521062251.GC24597@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1116596614.8156.11.camel@secureip.watson.ibm.com>
	 <20050521062251.GC24597@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/05, Greg KH <greg@kroah.com> wrote:
...
> 
> Wow, for such a small file, every single function was incorrect.  And
> you abused sysfs in a new and intersting way that I didn't think was
> even possible.  I think this is two new records you have set here,
> congratulations.
> 
> greg k-h
> 

never doubt that this should be the "quote of the week" for lwn.net ;-))

just kidding ;-))

regards,
aq
