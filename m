Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272209AbRH3NLG>; Thu, 30 Aug 2001 09:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272208AbRH3NK5>; Thu, 30 Aug 2001 09:10:57 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62728 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S272209AbRH3NKp>; Thu, 30 Aug 2001 09:10:45 -0400
Message-ID: <3B8E3B0C.DD7032FA@idb.hist.no>
Date: Thu, 30 Aug 2001 15:09:32 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.10-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108300956.f7U9u7D16494@wildsau.idv-edu.uni-linz.ac.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:
> 
> > Please guys. The issue of sign in comparisons are a LOT more complicated
> > than most of you seem to think.
> 
> as a friend of mine put it on IRC:
>   "Your little brains are not able to grasp the complicated issue of
>   sign in comparisons."
> 
> If the problem is compiler-related, shouldn't it be forwared to the
> gcc-group?
> 
C has (complicated) rules for this.  The gcc people can't break them in
order to
make it easier for developers to understand.  But you may of course
try a discussion on comp.lang.c

Helge Hafting
