Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129029AbQJ3G5p>; Mon, 30 Oct 2000 01:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129042AbQJ3G5g>; Mon, 30 Oct 2000 01:57:36 -0500
Received: from ra.lineo.com ([207.179.37.37]:14021 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129029AbQJ3G5T>;
	Mon, 30 Oct 2000 01:57:19 -0500
Message-ID: <39FD1C89.818B9821@lineo.com>
Date: Mon, 30 Oct 2000 00:00:26 -0700
From: pierre@lineo.com
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Savochkin <saw@saw.sw.com.sg>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: eepro100: card reports no resources [was VM-global...]
In-Reply-To: <20001026193508.A19131@niksula.cs.hut.fi> <20001030142356.A3800@saw.sw.com.sg>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 10/29/2000
 11:57:18 PM,
	Serialize complete at 10/29/2000 11:57:18 PM
Content-Type: multipart/alternative;
 boundary="------------29338EB3563DE90613B9FA2A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------29338EB3563DE90613B9FA2A
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

Andrey Savochkin wrote:

> > > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > > >
> > > let me guess: intel eepro100 or similar??
> >
> > > 2.4.0-test9-pre3 it doesnt happen on my machine ...

I run 2.4.0-test10-pre5 and it still does it.

Trick : "ifconfig eth0 down" then "ifconfig eth0 up" stops the problem for me
when it occurs.


                ////\
                (@ @)
------------oOOo-(_)-oOOo-------------
Pierre-Philippe Coupard
Software Engineer, Lineo, Inc.
Email : pierre@lineo.com
Phone : (801) 426-5001 x 208
--------------------------------------

Auribus teneo lupum.
        [I hold a wolf by the ears.]
        [Boy, it *sounds* good.  But what does it *mean*?]



--------------29338EB3563DE90613B9FA2A
Content-Transfer-Encoding: 7bit
Content-Type: text/html; charset=us-ascii

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Andrey Savochkin wrote:
<blockquote TYPE=CITE>> > > Oct 26 16:38:01 ns29 kernel: eth0: card reports
no resources.
<br>> > >
<br>> > let me guess: intel eepro100 or similar??
<br>>
<br>> > 2.4.0-test9-pre3 it doesnt happen on my machine ...</blockquote>
I run 2.4.0-test10-pre5 and it still does it.
<p>Trick : "ifconfig eth0 down" then "ifconfig eth0 up" stops the problem
for me when it occurs.
<pre>&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ////\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (@ @)
------------oOOo-(_)-oOOo-------------
Pierre-Philippe Coupard
Software Engineer, Lineo, Inc.
Email : pierre@lineo.com
Phone : (801) 426-5001 x 208
--------------------------------------

Auribus teneo lupum.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [I hold a wolf by the ears.]
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Boy, it *sounds* good.&nbsp; But what does it *mean*?]</pre>
&nbsp;</html>

--------------29338EB3563DE90613B9FA2A--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
