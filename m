Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130756AbQLITci>; Sat, 9 Dec 2000 14:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131818AbQLITcV>; Sat, 9 Dec 2000 14:32:21 -0500
Received: from cm698210-a.denton1.tx.home.com ([24.17.129.59]:35079 "HELO
	cm698210-a.denton1.tx.home.com") by vger.kernel.org with SMTP
	id <S130756AbQLITcL>; Sat, 9 Dec 2000 14:32:11 -0500
Message-ID: <3A328196.528D3BB4@home.com>
Date: Sat, 09 Dec 2000 13:01:42 -0600
From: Matthew Vanecek <linux4us@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <E144OAg-0003wh-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > wrong with it.  I've only seen this under 2.3.x/2.4 SMP kernels.  I
> > > would say that this is definitely a kernel problem.=20
> >
> > XFree86 3.9 and XFree86 4 were rock solid for a _long_ time on 2.[34]
> > kernels - even on my BP6=B9. The random crashes started to happen when =
> > I
> > upgraded my distribution=B2 - and are only seen by people using 2.4. So=
> >  I
> > suspect that it's the combination of glibc and kernel which is triggeri=
> > ng
> > it.
> 
> Have any of the folks seeing it checked if Ben LaHaise's fixes for the page
> table updating race help ?
> 
> Alan

Where are his fixes at?  I don't seem to see any of his posts in the
archives.
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
