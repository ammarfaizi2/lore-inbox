Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVCCFEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVCCFEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVCCEm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:42:59 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:6831 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261349AbVCCETy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:19:54 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFD: Kernel release numbering
Date: Wed, 2 Mar 2005 20:21:00 -0800
User-Agent: KMail/1.7
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <422674A4.9080209@pobox.com> <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503022021.00878.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 March 2005 19:37, Linus Torvalds wrote:

> That's the whole point here, at least to me. I want to have people test
> things out, but it doesn't matter how many -rc kernels I'd do, it just
> won't happen. It's not a "real release".
>
> In contrast, making it a real release, and making it clear that it's a
> release in its own right, might actually get people to use it.
>
> Might. Maybe.
>
Linus, I respect all of the work you have done on the Linux kernels over the 
years, and I have been an avid user of Linux almost since its inception (when 
I could get it to work with the hardware, at least in the early days ;-)  And 
the fact that my contributions to the kernel are almost nonexistent probbly 
means you won't pay attention to a word I say anyway :-)  that's alright, I'm 
going to say it and you can listen if you want.

My respect for your accomplishments is why it pains me a great deal to have to 
tell you that I think you're wrong.

I agree with the first part of your mail that I quoted above.  Indeed, the -rc 
releases are not a "real release", and therefore people aren't going to test 
it.

What you are missing is that if you use the method you have proposed. odd 
numberered kernels will stop being a "real release" as well to a great deal 
of users.

I don't think you will actually gain anything here except for just changing 
the kernel naming scheme yet *again*.  I certainly don't think you're going 
to solve the problem you are trying to solve.

The problem as stated is that people are not downloading and testing the test 
releases.

Your solution to that problem is to make test releases look like real releases 
and maybe people will test them anyway.

The solution should be to find a way to encourage people to download and test 
the test releases.  Perhaps a "bug bounty" of some kind (it doesn't have to 
be money), or something similar, may prove to be a better motivator than 
trying to trick the userbase.  It's not going to work.  If you take the 
motivational approach, then it won't matter what you name the test releases, 
people will test them anyway.

Several ideas right off the top of my head:
- a "bug bounty" as I mentioned above.
- a volunteer army of people, similar to the "kernel janitors", whose job is 
to do QA for the kernel.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Agoura, CA
