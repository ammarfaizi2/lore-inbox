Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWFTI5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWFTI5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWFTI5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:57:04 -0400
Received: from lucidpixels.com ([66.45.37.187]:63926 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S965219AbWFTI5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:57:02 -0400
Date: Tue, 20 Jun 2006 04:57:01 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Avuton Olrich <avuton@gmail.com>
cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
In-Reply-To: <3aa654a40606192340l67d0353fj875767d33d8bd493@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0606200456540.3182@p34.internal.lan>
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com> 
 <20060620161006.C1079661@wobbly.melbourne.sgi.com>
 <3aa654a40606192340l67d0353fj875767d33d8bd493@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you checked to make sure you don't have a bad disk?

On Mon, 19 Jun 2006, Avuton Olrich wrote:

> On 6/19/06, Nathan Scott <nathans@sgi.com> wrote:
>> How reproducible is it?  Is it reproducible even after xfs_repair?
> It happens everytime I try to delete the directory.
>
> Also, forgot to mention I ran xfs_check on it and it gave me more
> information than I had before:
> More information, ran xfs_check and got the following:
> missing free index for data block 0 in dir ino 1507133580
> missing free index for data block 2 in dir ino 1507133580
> missing free index for data block 3 in dir ino 1507133580
> missing free index for data block 4 in dir ino 1507133580
> missing free index for data block 5 in dir ino 1507133580
> missing free index for data block 6 in dir ino 1507133580
> missing free index for data block 7 in dir ino 1507133580
> missing free index for data block 8 in dir ino 1507133580
> missing free index for data block 9 in dir ino 1507133580
>
> -- 
> avuton
> --
> Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>
>
