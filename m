Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271297AbRHTPlJ>; Mon, 20 Aug 2001 11:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271311AbRHTPku>; Mon, 20 Aug 2001 11:40:50 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:13727
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S271283AbRHTPkk>; Mon, 20 Aug 2001 11:40:40 -0400
Message-ID: <3B812FD2.836572F5@nortelnetworks.com>
Date: Mon, 20 Aug 2001 11:42:10 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug McNaught <doug@wireboard.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org> <2251207905.998322034@[10.132.112.53]> <3B8124C4.7A4275B9@nortelnetworks.com> <m3k7zylpna.fsf@belphigor.mcnaught.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught wrote:
> 
> Chris Friesen <cfriesen@nortelnetworks.com> writes:
> 
> > Why don't we also switch to a cryptographically secure algorithm for
> > /dev/urandom?
> 
> It IS cryptographically secure.  Have you ever read the manpage?

Oops, my bad.  I got errors doing man on urandom, but neglected to try a man on
random.

The main reason for my comment was the suggestion by Steve Hill that
/dev/urandom was NOT cryptographically secure.  Re-reading it, his comment was
in the context of generating cryptographic keys, so perhaps I misunderstood what
he meant.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
