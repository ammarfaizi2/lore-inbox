Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbVIIGz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbVIIGz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 02:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbVIIGz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 02:55:28 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:27836 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751415AbVIIGz1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 02:55:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hKU8KdsTvD5tbjcUokXMZnod/P5PN1h6B//qvBpExgq3PK1VCBb6M3ggW9WNXTfP3RubHC/6yHMUW8d89OK+S1mLWC+pQWCE80M2X5mznfqJX3MOBkgTse4egx763SGjdnIhLDEWoBD8Bk+yjJxRSLMVgG6wJn/uWdS0cS6o+FQ=
Message-ID: <dda83e780509082355d28a8ef@mail.gmail.com>
Date: Thu, 8 Sep 2005 23:55:24 -0700
From: Bret Towe <magnade@gmail.com>
Reply-To: magnade@gmail.com
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: nfs4 client bug
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050906181327.GE10632@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e7805090320053b03615d@mail.gmail.com>
	 <dda83e78050904124454fc675a@mail.gmail.com>
	 <dda83e78050904135113b95c4a@mail.gmail.com>
	 <20050904215219.GA9812@fieldses.org>
	 <dda83e780509042008294fbe26@mail.gmail.com>
	 <20050905031825.GA22209@fieldses.org>
	 <dda83e78050905134420f06fbf@mail.gmail.com>
	 <9a87484905090513481118e67b@mail.gmail.com>
	 <dda83e7805090520407aefb4d1@mail.gmail.com>
	 <20050906181327.GE10632@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Mon, Sep 05, 2005 at 08:40:53PM -0700, Bret Towe wrote:
> > Pid: 14169, comm: xmms Tainted: G   M  2.6.13
> 
> Hm, can someone explain what that means?  A proprietary module was
> loaded then unloaded, maybe?
> 
> You may also want to retest with
> 
> http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.13-1/linux-2.6.13-001-NFS_ALL_MODIFIED.dif
> 
> applied, to make sure there isn't a patch in Trond's series that already
> fixes the bug.
> 
> --b.
> 

ive been running this since i got the url and so far i havent hit it
ive also been a bit busy so i havent been able to make sure its good
this weekend i should be able to test it and make sure its solved
