Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143406AbREKVnk>; Fri, 11 May 2001 17:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143407AbREKVnV>; Fri, 11 May 2001 17:43:21 -0400
Received: from hacksaw.org ([216.41.5.170]:21641 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S143406AbREKVnQ>; Fri, 11 May 2001 17:43:16 -0400
Message-Id: <200105112143.f4BLhDu08419@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: Wayne.Brown@altec.com, linux-kernel@vger.kernel.org
Subject: Re: Not a typewriter 
In-Reply-To: Your message of "Fri, 11 May 2001 11:07:45 CDT."
             <86256A49.00589003.00@smtpnotes.altec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 May 2001 17:43:13 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>If clarity is the most important consideration, then other things should be
>changed as well.  For instance, the command we use to search for text strings 
in
>files should be called "textsearch."  That's a lot more clear than "grep."

Well, I can't disagree. Unix's biggest turn off was the stupid command names. 
It's a big reason why Unixoid systems aren't more commonplace. I only learned 
it because I was stuck at a desk with a Wyse terminal. Otherwise I probably 
would have played with the Autocad machines more. Once I understood the 
basics, I understood the power of the system.

However, I was a CS major, smart, and a voracious reader. 

-----

I have often thought of an alternate naming scheme that would apply to the 
most basic utilities. With command completion longer names become less 
annoying.

But first we need a better help system. The absolute most stupid convention of 
Unix is the man command. The fact that SCCS before, and now Bash usurp the 
keyword "help" is beyond the pale.

>If the wording is going to be changed, then it's better to abandon the 
tradition

I say abandon tradition when tradition doesn't serve. Arcane messages prevent 
understanding, arbitrary command names sometimes can't be avoided. The process 
is annoying at best, and painful on Linux systems where the documentation 
isn't unified, and is often incomplete.

A beautiful example that came up on my RedHat 6.2 system:
[From ppd_file_new_from_filep(3)]

       ENOTTY no idea what these errors are. Probably PPD parse errors.

I run into things like this all the time.

"Textsearch" is better than grep, except sometimes you aren't searching 
through text. "Search" is more general. "Find" would be even better.

I wish that find had the functions of grep as well, ala the MacOS "find", 
which can (these days) search for files names and attributes, and also search 
for things inside files.

>My point is that someone who sees the "typewriter" message and doesn't
>understand it will have to dig a bit to find out what it means.

All well and good if you have the time. If you are in a business or academic 
settings, the learning curve is an important part of the total cost of 
ownership.

--------

Ob. LKML: Error messages from the kernel should be examined with this in mind. 
The more clear that error message is, the less likely we'll see a question 
about it here.



