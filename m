Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbRFLShE>; Tue, 12 Jun 2001 14:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263020AbRFLSgz>; Tue, 12 Jun 2001 14:36:55 -0400
Received: from mailsorter.in.tmpw.net ([63.121.29.25]:44321 "EHLO
	mailsorter1.in.tmpw.net") by vger.kernel.org with ESMTP
	id <S262682AbRFLSgl>; Tue, 12 Jun 2001 14:36:41 -0400
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C9B6AE1@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Rik van Riel'" <riel@conectiva.com.br>,
        Rob Landley <landley@webofficenow.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Nelson <mnelson@dynatec.com>,
        linux-kernel@vger.kernel.org
Subject: RE: Any limitations on bigmem usage?
Date: Tue, 12 Jun 2001 14:34:40 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2001, Rob Landley wrote:

> Brilliant.  You need what, a 6x larger cache just to break even with
> the amount of time you're running in-cache? 

This may be the wrong platform for this question, but after reading Rob
Landley's note on performance on Itanium and architecture concerns, I am
interested in Kernel hackers who have had to write code for Itanium's
comments on the same, if you are not bound by NDA's.  Correct me if I am
wrong, but I thought I saw the announcement that Itanium is shipping.  Have
you tested Itanium performance?  We have an preproduction unit with quad
Itanium's.  I have not had time to benchmark against other units, I am
interested in performance items.  Feel free to drop me a line off list if
you can.

B.
