Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbQJ3KkN>; Mon, 30 Oct 2000 05:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbQJ3KkC>; Mon, 30 Oct 2000 05:40:02 -0500
Received: from agrashak.cpg.com.au ([138.79.128.10]:58630 "HELO
	agrashak.cpg.com.au") by vger.kernel.org with SMTP
	id <S129067AbQJ3Kjr>; Mon, 30 Oct 2000 05:39:47 -0500
Message-ID: <39FD4FED.43C65FFC@cpgen.cpg.com.au>
Date: Mon, 30 Oct 2000 21:39:41 +1100
From: Grahame Jordan <jordg@cpgen.cpg.com.au>
Organization: Interim Technology Training Institute
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS, Can't get request slot
In-Reply-To: <E13p7sA-0004M5-00@the-village.bc.nu>
Content-Type: multipart/alternative;
 boundary="------------FDB901856F3995649012E784"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------FDB901856F3995649012E784
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan,

student:/susr/     /usr              nfs
defaults,rsize=1024,wsize=1024          0 0

Thanks

Graham Jordan


Alan Cox wrote:

> > By the evidence that we have gathered it seems that the Server is not
> > taxed too much as samba users are getting files OK etc.  The can't get
> > request slot is plaguing many others in different ways.   It looks like
> > an NFS issue.   How can this be proven?  Then we can work on the
> > problem.
>
> The request queue slot message means the server isnt responding (at least in
> the eyes of the client). Given you can get into the box that isnt the
> net card (at least not now). What mount options do you use ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--
Grahame Jordan
Network Manager
Interim Technology Training Institute
  Mobile: +61 3 0408 058 209
  Phone:  +61 3 9243 2220
  Fax:    +61 3 9820 2010
  e-mail: jordg@cpgen.cpg.com.au
  Transforming the way people work with technology with
  INTEGRITY LEARNING INNOVATION TEAMWORK PERFORMANCE



--------------FDB901856F3995649012E784
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Alan,
<p>student:/susr/&nbsp;&nbsp;&nbsp;&nbsp; /usr&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
nfs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; defaults,rsize=1024,wsize=1024&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
0 0
<p>Thanks
<p>Graham Jordan
<br>&nbsp;
<p>Alan Cox wrote:
<blockquote TYPE=CITE>> By the evidence that we have gathered it seems
that the Server is not
<br>> taxed too much as samba users are getting files OK etc.&nbsp; The
can't get
<br>> request slot is plaguing many others in different ways.&nbsp;&nbsp;
It looks like
<br>> an NFS issue.&nbsp;&nbsp; How can this be proven?&nbsp; Then we can
work on the
<br>> problem.
<p>The request queue slot message means the server isnt responding (at
least in
<br>the eyes of the client). Given you can get into the box that isnt the
<br>net card (at least not now). What mount options do you use ?
<br>-
<br>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
<br>the body of a message to majordomo@vger.kernel.org
<br>Please read the FAQ at <a href="http://www.tux.org/lkml/">http://www.tux.org/lkml/</a></blockquote>

<pre>--&nbsp;
Grahame Jordan
Network Manager
Interim Technology Training Institute
&nbsp; Mobile: +61 3 0408 058 209&nbsp;
&nbsp; Phone:&nbsp; +61 3 9243 2220
&nbsp; Fax:&nbsp;&nbsp;&nbsp; +61 3 9820 2010
&nbsp; e-mail: jordg@cpgen.cpg.com.au
&nbsp; Transforming the way people work with technology with&nbsp;
&nbsp; INTEGRITY LEARNING INNOVATION TEAMWORK PERFORMANCE</pre>
&nbsp;</html>

--------------FDB901856F3995649012E784--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
