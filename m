Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137203AbREKSjS>; Fri, 11 May 2001 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137204AbREKSi7>; Fri, 11 May 2001 14:38:59 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:8715 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S137203AbREKSiu>; Fri, 11 May 2001 14:38:50 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
cc: Hacksaw <hacksaw@hacksaw.org>, linux-kernel@vger.kernel.org
Message-ID: <86256A49.00664FCE.00@smtpnotes.altec.com>
Date: Fri, 11 May 2001 13:37:53 -0500
Subject: Re: Not a typewriter
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/11/2001 at 12:03:43 PM Joel Jaeggli <joelja@darkwing.uoregon.edu> wrote:

>it's not clear to me that that textsearch is a more  accurate description
>than Get Regular ExPression

It's not more accurate.  But Hacksaw's original point was that a new user would
not know what "not a typewriter" meant.  My point was that a newbie wouldn't be
likely to guess that "grep" means "search for text" either; in both cases he'd
have to look it up if he'd never seen it before.

BTW, grep does not stand for "Get Regular ExPression."  It comes from an
often-used command in the ed (and ex and vi) editor: g/re/p.  The "g" means
"global," the "re" is a regular expression, and the "p" means "print."  So to
search for all lines containing the word "foo" in a file you were editing, you
would type g/foo/p.  This was such a useful function that it was packaged in a
standalone program that could be used to search multiple files.

Wayne


