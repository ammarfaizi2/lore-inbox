Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282212AbRLVUWN>; Sat, 22 Dec 2001 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282222AbRLVUWD>; Sat, 22 Dec 2001 15:22:03 -0500
Received: from pD9053081.dip.t-dialin.net ([217.5.48.129]:61169 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S282212AbRLVUWA> convert rfc822-to-8bit; Sat, 22 Dec 2001 15:22:00 -0500
Date: Thu, 7 Jan 1904 09:32:10 +0100
From: Marc Heckmann <heckmann@hbe.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cerberus on 2.4.17-rc2 UP
Message-ID: <19040107093209.B1421@hbe.ca>
In-Reply-To: <20011220135904.B32516@hbe.ca> <Pine.LNX.4.21.0112211454140.7313-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.21.0112211454140.7313-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Dec 21, 2001 at 02:56:34PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 02:56:34PM -0200, Marcelo Tosatti wrote:
> 
> Can you please run Cerberus again and give me more information ?

I did and the machine made it through this time ( in 18 hours). The thing 
is that I skipped the LTP and crashme tests because last time, they 
finished in 8 hours succesfully and the machine only locked up after 14 so 
I thought that one of the other tests that were still running were 
responsible. 

In anz case, I don't have access to the box till thursday due to the 
holidays. I will re-run with all tests then.

Cheers, 

> 
> On Thu, 20 Dec 2001, marc. h. wrote:
> 
> > I tried out the latest cerberus from
> > http://people.redhat.com/bmatthews/cerberus/ on a UP redhat-7.2 box. I ran the
> > standard non-destructive RedHat tests.
> > 
> > It ran for about 14 hours and then became unresponsive..  machine still ping'ed
> > , I could switch VC's scroll up on console, but that's it. Could not log in,
> > etc.. Another point is that the hard drive light remained on but it was not
> > seeking, it seemed dead silent.
> 
> 
> 

-m

-- 
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/
