Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVBWP2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVBWP2t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVBWP2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:28:49 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:40975 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261298AbVBWP2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:28:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Zvpms9y7oOFyb/JhUMHtgZk0gCygDTdEOyDh3SkH0bwsQVhv/9pUxQCCLFm2usfpKWfeWi7ySpe0//JVfHI41Qm5wqaTKMtHO6XxHGqmhrBpaSJEJ69u30w/oU09pK1qRHmRP6ktZf4ARfGrAmgaqVtl2bhBrp7MVQ8M5eYQnbc=
Message-ID: <4d8e3fd30502230728283f7ec9@mail.gmail.com>
Date: Wed, 23 Feb 2005 16:28:32 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Andres Salomon <dilinger@voxel.net>
Subject: Re: 2.6.10-as5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109131720.9362.28.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109131720.9362.28.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas

On Tue, 22 Feb 2005 23:08:40 -0500, Andres Salomon <dilinger@voxel.net> wrote:
> Hi,
> 
> Here's 2.6.10-as5.  2.6.10-as4 was never officially announced; it had
> issues (note to self; test, *then* tag).  Distributors should note that
> there is an ABI/API change in this release, due to
> 114-netfilter_private_queues.patch changing ipv4 related function args.
> Modules that use these will most likely need to be rebuilt.
> 
> Lots of security fixes in here; it's probably a good idea to upgrade.
> If I'm missing any security related stuff, please let me know.  I have
[...]

Are you in contact with OSDL ?
I don't recall who (too lazy for searching in the archive) but someone
was willing to manintain a 2.6.x.y kernel including only security
fixes.
It could be a good idea to share with him your work.

-- 
Paolo
