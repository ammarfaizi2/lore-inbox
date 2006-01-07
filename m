Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWAGPJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWAGPJD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 10:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWAGPJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 10:09:01 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:6944 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030471AbWAGPJA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 10:09:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uvMAfyH9cmXc7EUK7vUMZ8WzVlIwSKmSILlweyOUuBpZooIV6B7KJkVIbxYHRv+I7oye0yJ5idmNhXgdZQlOAHvSaCCTIVetwx7LUEn9P/TIy1U4RRfMcGn1bKEQ57FeNBFz9CwU4zwOuBxe9A9pQwgNT1uZD3pYqAdvScSLJG8=
Message-ID: <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>
Date: Sat, 7 Jan 2006 16:08:59 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107052221.61d0b600.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/
>
> This should be somewhat less buggy than 2.6.15-mm1.
>
For some maybe. For me it's just as broken as 2.6.15-mm1 :-(

I'll turn on all debug switches and try and collect some crash dumps.
If there's anything specific you want me to try, let me know.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
