Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVKVWFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVKVWFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVKVWFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:05:23 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:44455 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030195AbVKVWFV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:05:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PwfetypZvd0xbtXgiJ6ujR9VxAcJyFpIP9/veNFiqCVKyfDzM7bcegwpJbgKyLatXA7mA5JjOOj3NaTuk3qImDWsKdR/dBkZ/uz+5mHBUknbAmxUne2aDp2XCwTnsrvJEwl58uOddJNRsF3Jol5EunRtuJ7i3DD80BZH6sySfM0=
Message-ID: <cbec11ac0511221405s3e05b936ofc17952e29463545@mail.gmail.com>
Date: Wed, 23 Nov 2005 11:05:20 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.15-rc1-mm1
Cc: Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051122205545.GB5396@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051117111807.6d4b0535.akpm@osdl.org>
	 <200511182024.33858.tomlins@cam.org>
	 <20051119012632.GA28458@kroah.com>
	 <200511182224.10392.tomlins@cam.org>
	 <20051121002623.GA11271@kroah.com>
	 <cbec11ac0511221247k7b72eb4bmbcaa8c522bd8c005@mail.gmail.com>
	 <20051122205545.GB5396@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Greg KH <greg@kroah.com> wrote:
> On Wed, Nov 23, 2005 at 09:47:49AM +1300, Ian McDonald wrote:
> > It is definitely not a kernel issue in my opinion.
>
> Thank you for following up on this and letting us know.
>
> greg k-h
>
It is in debian bug system as bug 340202. I have just posted more
information to it which should appear soon:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=340202

--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
