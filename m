Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130070AbQLJACK>; Sat, 9 Dec 2000 19:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbQLJACB>; Sat, 9 Dec 2000 19:02:01 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:29192 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S130070AbQLJABx>; Sat, 9 Dec 2000 19:01:53 -0500
Message-ID: <3A32C0CD.AAFB756E@home.com>
Date: Sat, 09 Dec 2000 17:31:25 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <Pine.LNX.4.21.0012091919170.560-100000@neo.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@suse.de wrote:
> 
> On Sat, 9 Dec 2000, Matthew Vanecek wrote:
> 
> > > Have any of the folks seeing it checked if Ben LaHaise's fixes for the page
> > > table updating race help ?
> > > Alan
> >
> > Where are his fixes at?  I don't seem to see any of his posts in the
> > archives.
> 
> dwmw2 posted one such patch earlier this week :-
> 
> http://www.lib.uaa.alaska.edu/linux-kernel/archive/2000-Week-49/0856.html
> 
> regards,
> 

I saw that.  I thought it was a patch to try to "reproduce it", as
opposed to fixing it.  Is it truly a fix, and is it applicable for UP
kernels?
-- 
Matthew Vanecek
perl -e 'print
$i=pack(c5,(41*2),sqrt(7056),(unpack(c,H)-2),oct(115),10);'
********************************************************************************
For 93 million miles, there is nothing between the sun and my shadow
except me.
I'm always getting in the way of something...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
