Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132246AbRAXA6s>; Tue, 23 Jan 2001 19:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132228AbRAXA6j>; Tue, 23 Jan 2001 19:58:39 -0500
Received: from io.frii.com ([216.17.128.3]:22794 "EHLO io.frii.com")
	by vger.kernel.org with ESMTP id <S132246AbRAXA6c>;
	Tue, 23 Jan 2001 19:58:32 -0500
Date: Tue, 23 Jan 2001 17:58:25 -0700
From: Nicholas Dronen <ndronen@frii.com>
To: Michael McLeod <michaelm@platypus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: monitoring I/O
Message-ID: <20010123175825.A88907@frii.com>
In-Reply-To: <8494866EDB1D3E4F9C7E6AC2F95C259B01DA1C@plat.platypus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <8494866EDB1D3E4F9C7E6AC2F95C259B01DA1C@plat.platypus.net>; from michaelm@platypus.net on Wed, Jan 24, 2001 at 11:52:36AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check out the disk_io field in /proc/stat.

On Wed, Jan 24, 2001 at 11:52:36AM +1100, Michael McLeod wrote:
> Hello
> 
> I am hoping someone can give me a little information or point me in the
> right direction.  I would like to write an application that monitors I/O
> on a linux machine, but I need some help in determining where to get the
> information I'm looking for.  What I would like to do is 'hook' into the
> kernel and record information such as volume name, type of request (read
> or write), the amount of data being read or written, how long each
> transaction takes....  
> 
> Any help would be greatly appreciated, or if there is something like
> this already available that would be even better.  Thanx
> 
> Mike
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
