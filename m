Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVIWSKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVIWSKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbVIWSKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:10:14 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:268 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750964AbVIWSKN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:10:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I4onUKbe+zY019uIviAE/gRJZORa3UQ/BojpDVoNvMVOS2GTCZ+rq8vrE4E+GyOPZJwRwPub58uCIW3uPugVcKiFO6EDa0Q4cNTcMJviFmGKd68Ky1xfBjnCAv2+3nRvKdzBJSOXqb2SLKyzApuhhjb+OXpoeK2AGlcQuYJfXt8=
Message-ID: <1e62d137050923111046d0b762@mail.gmail.com>
Date: Fri, 23 Sep 2005 23:10:12 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Trapping Block I/O
Cc: Block Device <blockdevice@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050923180407.GG22655@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <64c7635405092305433356bd17@mail.gmail.com>
	 <1e62d137050923103843058e92@mail.gmail.com>
	 <20050923180407.GG22655@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Jens Axboe <axboe@suse.de> wrote:
> On Fri, Sep 23 2005, Fawad Lateef wrote:
> > you created wrapper .... So by doing this you can easily monitor
> > requests (similar to this approach is used in LVM/RAID) ......
>
> Or just use btrace, pull it from:
>
> git://brick.kernel.dk/data/git/blktrace.git
>

Thnx for telling about btrace .... I havn't tried/looked at it before !!!!


--
Fawad Lateef
