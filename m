Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265726AbRFYRjV>; Mon, 25 Jun 2001 13:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265878AbRFYRjL>; Mon, 25 Jun 2001 13:39:11 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:16095 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S265726AbRFYRi6>; Mon, 25 Jun 2001 13:38:58 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDEF5@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Chris Wedgwood'" <cw@f00f.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, proski@gnu.org,
        linux-kernel@vger.kernel.org
Subject: RE: ACPI + Promise IDE = disk corruption :-(((
Date: Mon, 25 Jun 2001 10:38:12 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Their processor power state code looks dormant at the moment, so they
haven't hit this particular issue.

They have in the past run into a number of problems, and submitted fixes.
The Linux version is getting much wider testing right now.

-- Andy

PS Just FreeBSD, no Net or OpenBSD just yet.

> From: Chris Wedgwood [mailto:cw@f00f.org]
>>     It's just *one* issue that has generated all the disk corruption
>>     reports.
> 
> The same code is used for FreeBSD and friends too right? Are they
> seeing anywhere near the same number of types of poroblems Linux is?

