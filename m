Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265296AbUBANMs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 08:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbUBANMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 08:12:48 -0500
Received: from [202.125.86.130] ([202.125.86.130]:18632 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S265296AbUBANMq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 08:12:46 -0500
Subject: FW: Linux device driver using c++!
Date: Sun, 1 Feb 2004 18:37:19 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-ID: <1118873EE1755348B4812EA29C55A9720DE156@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Thread-Topic: Linux device driver using c++!
Thread-Index: AcPowwfKmK7SdruuR92jP8cOEZLfcgAAH77gAAAw6sA=
From: "Jinu M." <jinum@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there someway I can make use of a OS independent C++ code. This code has classes, new, delete etc.. My plan was to build a static library using the C++ code and then write a simple OS interface module which has the init, cleanup, read, write, ioctl etc but calls C++ functions in the library.

Is this scenario possible?

-Jinu


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Måns Rullgård
Sent: Sunday, February 01, 2004 6:32 PM
To: linux-kernel@vger.kernel.org
Subject: Re: Linux device driver using c++!

"Jinu M." <jinum@esntechnologies.co.in> writes:

> I am new to Linux based device driver development.  I wanted to know
> if it is possible to write a Linux device driver (kernel loadable
> module) using C++.

It's impossible.

-- 
Måns Rullgård
mru@kth.se

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
