Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbQJ0E3b>; Fri, 27 Oct 2000 00:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQJ0E3W>; Fri, 27 Oct 2000 00:29:22 -0400
Received: from agrashak.cpg.com.au ([138.79.128.10]:59399 "HELO
	agrashak.cpg.com.au") by vger.kernel.org with SMTP
	id <S129550AbQJ0E3R>; Fri, 27 Oct 2000 00:29:17 -0400
Message-ID: <39F904AA.A585C3FF@cpgen.cpg.com.au>
Date: Fri, 27 Oct 2000 15:29:30 +1100
From: Grahame Jordan <jordg@cpgen.cpg.com.au>
Organization: Interim Technology Training Institute
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: NFS, Can't get request slot
Content-Type: multipart/alternative;
 boundary="------------71BB0AD1A92F65F7A6886F87"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------71BB0AD1A92F65F7A6886F87
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

We have /usr mounted over NFS on our workstations  RH6.2
Server RH 6.2
nfs-utils-0.1.9.1-1
Kernel 2.2.16

These workstations happily use samba and other services without any
delays but with NFS they hang in X for up to 15 minutes before NFS come
back.
We can ssh into the workstations and use any utility underneath X
without any problems whilst it is hung in X.

We have changed  the Server eepro100 for a 3com 3c95x with no difference

according to what has been alluded to in other kernel posts.

By the evidence that we have gathered it seems that the Server is not
taxed too much as samba users are getting files OK etc.  The can't get
request slot is plaguing many others in different ways.   It looks like
an NFS issue.   How can this be proven?  Then we can work on the
problem.

Thanks

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



--------------71BB0AD1A92F65F7A6886F87
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
Hi,
<p>We have /usr mounted over NFS on our workstations&nbsp; RH6.2
<br>Server RH 6.2
<br>nfs-utils-0.1.9.1-1
<br>Kernel 2.2.16
<p>These workstations happily use samba and other services without any
<br>delays but with NFS they hang in X for up to 15 minutes before NFS
come
<br>back.
<br>We can ssh into the workstations and use any utility underneath X
<br>without any problems whilst it is hung in X.
<p>We have changed&nbsp; the Server eepro100 for a 3com 3c95x with no difference
<br>according to what has been alluded to in other kernel posts.
<p>By the evidence that we have gathered it seems that the Server is not
<br>taxed too much as samba users are getting files OK etc.&nbsp; The can't
get
<br>request slot is plaguing many others in different ways.&nbsp;&nbsp;
It looks like
<br>an NFS issue.&nbsp;&nbsp; How can this be proven?&nbsp; Then we can
work on the
<br>problem.
<p>Thanks
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

--------------71BB0AD1A92F65F7A6886F87--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
