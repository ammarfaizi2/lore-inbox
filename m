Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVDKXXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVDKXXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 19:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVDKXXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 19:23:05 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:33092 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261986AbVDKXXD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 19:23:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ONLVVYx7G6cfyJvFuaTjfVSrd7dzVNi1M+kE/BEh6ULqijr3H6jQZxUGwfHKWSZdmNtGeL2qrKAreZd9MuGq90lkuQAMh9krkzeP9QiynMiQoT51D6iP8ZWwbpMZHI46XASjSFgKRqesXxvZsTRFOh2UKHYvliJpkphspiw8kRI=
Message-ID: <aec7e5c30504111623309582d5@mail.gmail.com>
Date: Tue, 12 Apr 2005 01:23:02 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Petr Baudis <pasky@ucw.cz>
Subject: Re: Call to atention about using hash functions as content indexers (SCM saga)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050411225139.GA9145@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050411224021.GA25106@larroy.com>
	 <20050411225139.GA9145@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/05, Petr Baudis <pasky@ucw.cz> wrote:

> (iv) You fail to propose a better solution.

I would feel safer with back end storage filenames based on email and
mtime together with an optional hash lookup that turns collisions into
worse performance. But that's just me.

/ magnus
