Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTJ2L5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 06:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTJ2L5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 06:57:24 -0500
Received: from mail1.neceur.com ([193.116.254.3]:45054 "EHLO mail1.neceur.com")
	by vger.kernel.org with ESMTP id S262030AbTJ2L5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 06:57:23 -0500
To: "Brad House" <brad_mssw@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: nforce2 stability on 2.6.0-test5 and 2.6.0-test9
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OF5F77CBA2.09E02070-ON80256DCE.00413294-80256DCE.0041A702@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Wed, 29 Oct 2003 11:57:05 +0000
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 10/29/2003 11:57:05 AM,
	Serialize complete at 10/29/2003 11:57:05 AM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 10/29/2003 11:57:06 AM,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 10/29/2003 11:57:08 AM,
	Serialize complete at 10/29/2003 11:57:08 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad,

I'm running an ASUS A7N8X Deluxe mobo (nforce2 chipset) and still
getting hardlockups.  I applied your patch but my system still locked
up after about a day.  However 2.6.0-test5 seems to be stable.  I have
had my system up for over three weeks with APIC and ACPI turned on.

Just to let you know,

Ross

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."
