Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269041AbRG3RiI>; Mon, 30 Jul 2001 13:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269040AbRG3Rh6>; Mon, 30 Jul 2001 13:37:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29409 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269030AbRG3Rhp>;
	Mon, 30 Jul 2001 13:37:45 -0400
Importance: Normal
Subject: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism: Prioritized
 Accept Queue
To: kuznet@ms2.inr.ac.ru, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        lartc@mailman.ds9a.nl, diffserv-general@lists.sourceforge.net,
        rusty@rustcorp.com.au, thiemo@sics.se,
        "Sridhar Samudrala" <samudrala@us.ibm.com>,
        "Renu Tewari" <tewarir@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF8753E938.DCEA2C85-ON85256A99.005DE1F6@pok.ibm.com>
From: "Douglas M Freimuth" <dmfreim@us.ibm.com>
Date: Mon, 30 Jul 2001 13:36:26 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/30/2001 01:36:29 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Fri, 27 Jul 2001,Sridhar wrote:

>The documentation on HOWTO use this patch and the test results which show
an
>improvement in connection rate for higher priority classes can be found at
our
>project website.
>        http://oss.software.ibm.com/qos

     For additional detail regarding the Prioritized Accept Queue (PAQ)
patch please read
"Kernel Mechanisms for Service Differentiation in Overloaded Web Servers"
originally published in
the 2001 Proceedings of the USENIX Annual Technical Conference
(USENIX Association, 2001), pp. 189-202. at the following USENIX site:

http://www.usenix.org/publications/library/proceedings/usenix01/voigt.html

For USENIX  nonmembers later this week will "reprint" this USENIX paper on
our project
website.
     http://oss.software.ibm.com/qos

--Doug
=================================================================
Doug Freimuth
   IBM TJ Watson Research Center
   Office  914-784-6221
   dmfreim@us.ibm.com

