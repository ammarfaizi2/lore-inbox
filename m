Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278974AbRJVVsw>; Mon, 22 Oct 2001 17:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278965AbRJVVsp>; Mon, 22 Oct 2001 17:48:45 -0400
Received: from pc3-oxfo3-0-cust171.oxf.cable.ntl.com ([213.107.68.171]:26891
	"EHLO noetbook.telent.net") by vger.kernel.org with ESMTP
	id <S278967AbRJVVhS>; Mon, 22 Oct 2001 17:37:18 -0400
to: linux-kernel@vger.kernel.org
Subject: Re: increase the number of system call parameters
In-Reply-To: <Pine.LNX.4.33.0110221334200.1121-100000@hagbart.nvg.ntnu.no> <k2r8rvvq3s.fsf@zero.aec.at>
From: Daniel Barlow <dan@telent.net>
Date: 22 Oct 2001 22:37:46 +0100
In-Reply-To: Andi Kleen's message of "22 Oct 2001 14:03:35 +0200"
Message-ID: <87zo6j8ifp.fsf@noetbook.telent.net>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> A note on design: if you have a function call that needs 12 arguments you
> probably forgot some[1] (in short it is a strong cue for a broken design,
> you should probably split it in smaller calls) 

> [1] unknown author

 If you have a procedure with 10 parameters, you probably missed some.
                          -- Alan Perlis, SIGPLAN Notices Vol. 17, No. 9


<URL:http://www-pu.informatik.uni-tuebingen.de/users/klaeren/epigrams.html>


-dan

-- 

  http://ww.telent.net/cliki/ - Link farm for free CL-on-Unix resources 
