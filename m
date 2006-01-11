Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWAKNn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWAKNn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWAKNn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:43:29 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:40499 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751343AbWAKNn2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:43:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jot4kosmyj4QtHAILrgZ+kFFmKkEFVhIDQLt4m93Sjwaev/AyOm/mCShMl3KprpQ0SxY3/qHLgxtb/EXuJczbXZrO/5ghLUerQjm+YORFyLKz6JoKSarlfgqPf4MuTuqB4gRmXfKCto0sFoUV5o/o8y0lwoTwUG8PzkV7YLSjHM=
Message-ID: <84144f020601110543t50939779g1e11784cb1b98fc1@mail.gmail.com>
Date: Wed, 11 Jan 2006 15:43:22 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060111042135.24faf878.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Andrew Morton <akpm@osdl.org> wrote:
> - If you hit a bug in -mm and it's not obvious which patch caused it, it is
>   most valuable if you can perform a bisection search to identify which patch
>   introduced the bug.  Instructions for this process are at
>
>         http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

You probably meant this one:

http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
