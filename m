Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318440AbSGZTJE>; Fri, 26 Jul 2002 15:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318441AbSGZTJE>; Fri, 26 Jul 2002 15:09:04 -0400
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:58865 "HELO
	dardhal.mired.net") by vger.kernel.org with SMTP id <S318440AbSGZTJD>;
	Fri, 26 Jul 2002 15:09:03 -0400
Date: Fri, 26 Jul 2002 21:05:20 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: How to start on new db-based FS?
Message-ID: <20020726190520.GA3192@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020726160742.GA951@ksu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020726160742.GA951@ksu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 26 July 2002, at 11:07:42 -0500,
Johnny Q. Hacker wrote:

> I'm looking to start work in the next half-year to year on a filesystem
>   with LDAP and then maybe later someSQL backing.  Where's a good place
>   to start?  I'm going to have a look at NFS, because I think I might
>   be able to use its interface into the kernel (I'm planning on making
>   it a userspace daemon).  Maybe autofs, although I think that's a
>   different interface.
>
Just a pointer to a project on filesystems that seems "revolutionary" in
concepts and objectives: ReiserFS 4 (http://www.namesys.com).

Please don't ask me about details, because I don't know a thing about
filesystem design and such :-), but documentation at the above site can 
give you some ideas, and maybe a place to start contributing.

Regards, 

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Woody (Linux 2.4.19-pre6aa1)
