Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274815AbRIUUSJ>; Fri, 21 Sep 2001 16:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274810AbRIUUSE>; Fri, 21 Sep 2001 16:18:04 -0400
Received: from mail.zmailer.org ([194.252.70.162]:43793 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S274815AbRIUURx>;
	Fri, 21 Sep 2001 16:17:53 -0400
Date: Fri, 21 Sep 2001 23:18:05 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: bdnelson@austin.rr.com, mjustice@austin.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Systems falsely rejecting email as POSSIBLE SPAM...
Message-ID: <20010921231805.P11046@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xmQNNkfJFyghCYbI"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xmQNNkfJFyghCYbI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Really,

  These "system rejects the message because it smells of spam"
are a sign of sysadmin stupidity.

I am entirely happy if (occasionally slipping thru) REAL SPAM is rejected,
but these POSSIBLE SPAM rejects are really ...

Various variants of this very same stupidity seems to be spreading
along with resulting weakening reliability of email.

It is beginning to look like the cures are worse than the sickness
in itself.


One of these weeks I plan to start composing a document titled
"ways to decrease your email system reliability"  covering these
ill-constructed anti-spam measures, and many other topics...

  /Matti Aarnio  -- co-postmaster of vger.kernel.org

--xmQNNkfJFyghCYbI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Received: from vger.kernel.org ([IPv6:::ffff:199.183.24.194]:18663 "EHLO
	vger.kernel.org" smtp-auth: <none> TLS-CIPHER: <none> TLS-PEER: <none>)
	by mail.zmailer.org with ESMTP id <S2802305AbRIUUEg>;
	Fri, 21 Sep 2001 23:04:36 +0300
Received: ("??"@vger.kernel.org) by vger.kernel.org id <S274806AbRIUUEB>;
	Fri, 21 Sep 2001 16:04:01 -0400
To:	linux-kernel-owner@vger.kernel.org
From:	The Post Office <postmaster@vger.kernel.org>
Sender:	mailer-daemon@vger.kernel.org
Subject: Delivery reports about your email [FAILED(2)]
MIME-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="S274806AbRIUUEB=_/vger.kernel.org"
Message-Id: <20010921200409Z274806-761+11204@vger.kernel.org>
Date:	Fri, 21 Sep 2001 16:04:01 -0400
Return-Path: <>
X-Envelope-To: <mea+vger.redhat.com@zmailer.org> (uid 99)
X-Orcpt: rfc822;postoffice

This is MULTIPART/REPORT structured message as defined at RFC 1894.

Ask your email client software vendor, when will they support this
report format by showing its formal part in your preferred language.

--S274806AbRIUUEB=_/vger.kernel.org
Content-Type: text/plain

This is a collection of reports about email delivery
process concerning a message you originated.

Some explanations/translations for these reports
can be found at:
      http://www.zmailer.org/reports.html

Generic VGER note:  Joining/leaving VGER's lists thru server:
			majordomo@vger.kernel.org

FAILED:
  Original Recipient:
    rfc822;bdnelson@austin.rr.com
  Control data:
    smtp austin.rr.com bdnelson@austin.rr.com 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=2885
    ->> 250 2.1.0 <linux-kernel-owner@vger.kernel.org>... Sender ok
    <<- RCPT To:<mjustice@austin.rr.com> NOTIFY=FAILURE ORCPT=rfc822;mjustice@austin.rr.com
    ->> 250 2.1.5 <mjustice@austin.rr.com>... Recipient ok
    <<- DATA
    ->> 354 Enter mail, end with "." on a line by itself
    <<- .
    ->> 553 5.0.0 Possible Spam
FAILED:
  Original Recipient:
    rfc822;mjustice@austin.rr.com
  Control data:
    smtp austin.rr.com mjustice@austin.rr.com 99
  Diagnostic texts:
...\
    <<- MAIL From:<linux-kernel-owner@vger.kernel.org> BODY=8BITMIME SIZE=2885
    ->> 250 2.1.0 <linux-kernel-owner@vger.kernel.org>... Sender ok
    <<- RCPT To:<mjustice@austin.rr.com> NOTIFY=FAILURE ORCPT=rfc822;mjustice@austin.rr.com
    ->> 250 2.1.5 <mjustice@austin.rr.com>... Recipient ok
    <<- DATA
    ->> 354 Enter mail, end with "." on a line by itself
    <<- .
    ->> 553 5.0.0 Possible Spam

Following is a copy of MESSAGE/DELIVERY-STATUS format section below.
It is copied here in case your email client is unable to show it to you.
The information here below is in  Internet Standard  format designed to
assist automatic, and accurate presentation and usage of said information.
In case you need human assistance from the Postmaster(s) of the system which
sent you this report, please include this information in your question!

    Virtually Yours,
        Automatic Email Delivery Software

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Fri, 21 Sep 2001 15:47:39 -0400
Local-Spool-ID: S274798AbRIUTrj

Original-Recipient: rfc822;bdnelson@austin.rr.com
Final-Recipient: RFC822;bdnelson@austin.rr.com
Action: failed
Status: 5.0.0
Diagnostic-Code: smtp; 553 (Possible Spam)
Remote-MTA: dns; txmx02.mgw.rr.com (24.93.35.223|25|199.183.24.194|54328)
Last-Attempt-Date: Fri, 21 Sep 2001 15:51:02 -0400
X-ZTAID: smtp[22478]

Original-Recipient: rfc822;mjustice@austin.rr.com
Final-Recipient: RFC822;mjustice@austin.rr.com
Action: failed
Status: 5.0.0
Diagnostic-Code: smtp; 553 (Possible Spam)
Remote-MTA: dns; txmx02.mgw.rr.com (24.93.35.223|25|199.183.24.194|54328)
Last-Attempt-Date: Fri, 21 Sep 2001 15:51:02 -0400
X-ZTAID: smtp[22478]


Following is copy of the message headers. Original message content may
be in subsequent parts of this MESSAGE/DELIVERY-STATUS structure.

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274798AbRIUTrj>; Fri, 21 Sep 2001 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274799AbRIUTr3>; Fri, 21 Sep 2001 15:47:29 -0400
Received: from c007-h015.c007.snv.cp.net ([209.228.33.222]:28899 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274798AbRIUTrS>;
	Fri, 21 Sep 2001 15:47:18 -0400
Received: (cpmta 3394 invoked from network); 21 Sep 2001 12:47:36 -0700
Received: from 208-186-44-038.elimm.quik.com (HELO distributopia.com) (208.186.44.38)
  by smtp.distributopia.com (209.228.33.222) with SMTP; 21 Sep 2001 12:47:36 -0700
X-Sent:	21 Sep 2001 19:47:36 GMT
Message-ID: <3BAB9790.8DB400C@distributopia.com>
Date:	Fri, 21 Sep 2001 14:40:00 -0500
From:	"Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: /dev/yapoll : Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010921114539.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org


--S274806AbRIUUEB=_/vger.kernel.org
Content-Type: message/delivery-status

Reporting-MTA: dns; vger.kernel.org
Arrival-Date: Fri, 21 Sep 2001 15:47:39 -0400
Local-Spool-ID: S274798AbRIUTrj

Original-Recipient: rfc822;bdnelson@austin.rr.com
Final-Recipient: RFC822;bdnelson@austin.rr.com
Action: failed
Status: 5.0.0
Diagnostic-Code: smtp; 553 (Possible Spam)
Remote-MTA: dns; txmx02.mgw.rr.com (24.93.35.223|25|199.183.24.194|54328)
Last-Attempt-Date: Fri, 21 Sep 2001 15:51:02 -0400
X-ZTAID: smtp[22478]

Original-Recipient: rfc822;mjustice@austin.rr.com
Final-Recipient: RFC822;mjustice@austin.rr.com
Action: failed
Status: 5.0.0
Diagnostic-Code: smtp; 553 (Possible Spam)
Remote-MTA: dns; txmx02.mgw.rr.com (24.93.35.223|25|199.183.24.194|54328)
Last-Attempt-Date: Fri, 21 Sep 2001 15:51:02 -0400
X-ZTAID: smtp[22478]

--S274806AbRIUUEB=_/vger.kernel.org
Content-Type: message/rfc822

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274798AbRIUTrj>; Fri, 21 Sep 2001 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274799AbRIUTr3>; Fri, 21 Sep 2001 15:47:29 -0400
Received: from c007-h015.c007.snv.cp.net ([209.228.33.222]:28899 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S274798AbRIUTrS>;
	Fri, 21 Sep 2001 15:47:18 -0400
Received: (cpmta 3394 invoked from network); 21 Sep 2001 12:47:36 -0700
Received: from 208-186-44-038.elimm.quik.com (HELO distributopia.com) (208.186.44.38)
  by smtp.distributopia.com (209.228.33.222) with SMTP; 21 Sep 2001 12:47:36 -0700
X-Sent:	21 Sep 2001 19:47:36 GMT
Message-ID: <3BAB9790.8DB400C@distributopia.com>
Date:	Fri, 21 Sep 2001 14:40:00 -0500
From:	"Christopher K. St. John" <cks@distributopia.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.0.36 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: /dev/yapoll : Re: [PATCH] /dev/epoll update ...
In-Reply-To: <XFMail.20010921114539.davidel@xmailserver.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender:	linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> Instead of requesting /dev/epoll changes to make it
> something that is not born for, i think that the /dev/poll
> patch can be improved in a significant way.
>

 I think there's agreement that Davide doesn't want
to change his /dev/epoll code.

 So, as an experiment, I'm modifying /dev/epoll to
more closely match the interface described in:

  http://citeseer.nj.nec.com/banga99measuring.html

 The paper describes in detail an event based
notification mechanism for determining which fd's are
ready for processing. Linux-/dev/poll is, and 
/dev/epoll appears to be, a variant of the mechanism
described in the paper.

 To save further pointless argument, I'm calling the
experiment "/dev/yapoll". 

 Specifically, I've added code to return the initial
state of the fd's as they are added to the interest
list. It seems to work ok so far, but I'll be doing
some benchmarking this weekend. I will post a patch
if no problems turn up.

 Davide seems to think it would be better to start
with the Linux-/dev/poll patch, but I disagree
(/dev/epoll itself appears to be based on the
Linux-/dev/poll code) I guess I'll soon find out if
he was right.


-- 
Christopher St. John cks@distributopia.com
DistribuTopia http://www.distributopia.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--S274806AbRIUUEB=_/vger.kernel.org--

--xmQNNkfJFyghCYbI--
