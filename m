Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286011AbRLTDrn>; Wed, 19 Dec 2001 22:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286012AbRLTDrd>; Wed, 19 Dec 2001 22:47:33 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:55393 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286011AbRLTDrU>; Wed, 19 Dec 2001 22:47:20 -0500
Date: Wed, 19 Dec 2001 22:47:17 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: billh@tierra.ucsd.edu, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
Message-ID: <20011219224717.A3682@redhat.com>
In-Reply-To: <20011219182628.A13280@burn.ucsd.edu> <20011219.184527.31638196.davem@redhat.com> <20011219190716.A26007@burn.ucsd.edu> <20011219.191354.65000844.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.191354.65000844.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 07:13:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 07:13:54PM -0800, David S. Miller wrote:
> I don't think AIO, because of it's non-trivial impact to the tree, is
> at all outside the scope of this list.  This is in fact the place
> where major stuff like AIO is meant to be discussed, not some special
> list where only "AIO people" hang out, of course people on that list
> will be enthusiastic about AIO!

Well maybe yourself and others should make some comments about it then.

> Frankly, on your other comments, I don't give a rats ass what BSD/OS
> people are doing about, nor how highly they rate, Java.  That is
> neither here nor there.  Java is going to be dead in a few years, and
> let's just agree to disagree about this particular point ok?

Who cares about Java?  What about high performance LDAP servers or tux-like 
userspace performance?  How about faster select and poll?  An X server that 
doesn't have to make a syscall to find out that more data has arrived?  What 
about nbd or iscsi servers that are in userspace and have all the benefits 
that their kernel side counterparts do?

		-ben
-- 
Fish.
