Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVKGFUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVKGFUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 00:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVKGFUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 00:20:30 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:5961 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751298AbVKGFUa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 00:20:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I0oYMKmS5K+DXmxPWKsfVCR9czMtchtbRYx9ZkQfgSbpl/3ur7ETnvJ3mEAnaJGMmNowJnwUmX49aNQZRJmPnIxw2VuyAVEmzaodEu25zOI0ouQrJjqrFsUoRNMWdS+68+cYMgWwflPk+Rha5lYsxYPHCWZabas9c2dMaSX0Z7Y=
Message-ID: <2cd57c900511062120o4f6a59bfy@mail.gmail.com>
Date: Mon, 7 Nov 2005 13:20:28 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + readahead-commentary.patch added to -mm tree
Cc: akpm@osdl.org
In-Reply-To: <200511030145.jA31j8eB021068@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511030145.jA31j8eB021068@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/3, akpm@osdl.org <akpm@osdl.org>:
>
> The patch titled
>
>      readahead commentary
>
> has been added to the -mm tree.  Its filename is
>
>      readahead-commentary.patch
>
>
> From: Andrew Morton <akpm@osdl.org>
>
> Add a few comments surrounding thr generic readahead API.
>

typo. s/thr/the/

> Also convert some ulongs into pgoff_t: the identifier for PAGE_CACHE_SIZE
> offsets into pagecache.

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
