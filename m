Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263957AbTLELaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 06:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTLELaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 06:30:30 -0500
Received: from mail.webmaster.com ([216.152.64.131]:31193 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S263957AbTLELa2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 06:30:28 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Fri, 5 Dec 2003 03:25:47 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEJJIHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200312051135.hB5BZ2V06015@adam.yggdrasil.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	The direct infringement occurs occurs when a user creates an
> infringing work in RAM, which I think is restrictable for works that
> are licensed rather than sold due to the US 9th circuit federal
> appeals court decision MAI Systems Corp. v. Peak Computer [1]:

	The GPL says:

Activities other than copying, distribution and modification are not
covered by this License; they are outside its scope.  The act of
running the Program is not restricted, and the output from the Program
is covered only if its contents constitute a work based on the
Program (independent of having been made by running the Program).
Whether that is true depends on what the Program does.

	So how is running the program infringement of a license that clearly says
executing is unrestricted? How do you execute without copying into RAM?
(Again, a license to do X is automatically a license to do anything
necessary to do X.)

> 	The second, more practically restrictable, potential form of
> infringement is contributory infringement by those who distribute
> proprietary kernel modules, such as authors, FTP site maintainers,
> vendors, and their employees.  Even if proprietary Linux kernel module
> is shipped as an object which has other uses besides being linked into
> Linux, it invariably requires "glue" code to work in Linux.  _Even
> when the "glue" code is open source_, if it's only substantial use is
> to form part of an infringing work in RAM, then it is a contributory
> infringement device.  Here is a diagram to help illustrate:

	Except that the act of running the program is unrestricted. So the
"infringing work in RAM" does not and cannot exist.

> 	The glue code may be part of the proprietary module or may be
> distributed as a separate middle layer module.  This code usually has
> no "substantial non-infringing use", thereby failing the test
> established for contributory copyright infringement from the 1984 US
> Supreme court decision, Sony Corporation of America v. Universal City
> Studios, Inc. [6], which basically set the common law test for
> contributory copyright infringement to be the same as the statutory
> standard for contributory patent infringement [7].

	This argument is pure bootstrapping. If the glue code is a license boundary
(which is most likely its purpose) that is has no infringing use!

	DS


