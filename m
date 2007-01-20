Return-Path: <linux-kernel-owner+w=401wt.eu-S965246AbXATK3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965246AbXATK3r (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 05:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbXATK3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 05:29:47 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:2628 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965246AbXATK3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 05:29:47 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
Date: Sat, 20 Jan 2007 02:29:40 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEIPBAAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200701200908.47654.Michal.Kudla@gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 20 Jan 2007 03:32:12 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 20 Jan 2007 03:32:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [1.] One line summary of the problem: 
> KB->KiB, MB -> MiB, ... (IEC 60027-2 Letter symbols to be used in 
> electrical 
> technology – Part 2)
> Should be everywere KiB, MiB, GiB, ... according to IEC 60027-2 

	Bytes are not an SI unit. A "megabyte" doesn't have to be a million bytes any more than a "megaphone" has to be a million phones. A "megabyte" is 1,048,576 bytes. The "mega" in there is not an SI prefix. "Mega" is only an SI prefix when it appears before an SI unit.

	DS


