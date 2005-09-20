Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbVITWS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbVITWS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVITWS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:18:58 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:37438 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965175AbVITWS6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:18:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XCezJNZSwD7x+7bqfmvERm2he38ocMWI4BnvVQpiMHxqhyWBFNzrW9Y/dn3kC3HJvwTbZtq0td5z1bMbyB1lFnH3OZ5+/SgYqjnYfS686b3Mh5TAhnq27B44QIs8uLEXNLxcy8mae7fvwUWrlYdXfczI3UHnmnHPBqkslmCpu9Y=
Message-ID: <9a8748490509201518248b66d1@mail.gmail.com>
Date: Wed, 21 Sep 2005 00:18:50 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: Hot-patching
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43308815.1000200@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43308815.1000200@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/05, John Richard Moser <nigelenki@comcast.net> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Oftentimes distributions spin on a stable kernel, but occasionally
> update it for security bugs.  This then demands a reboot, or you sit on
> a buggy kernel for however long.
> 

This has been discussed time and time again on this list and elsewhere
over the years. The most recent discussion I recall is the "[PATCH
x86_64] Live Patching Function on 2.6.11.7" thread which drew over 50
comments and got into a lot of corners - I'd suggest you go read it in
the archives.
Spend a little time searching and you'll find several other threads
about this in lkml archives.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
