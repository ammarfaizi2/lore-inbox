Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbSLPO0r>; Mon, 16 Dec 2002 09:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbSLPO0r>; Mon, 16 Dec 2002 09:26:47 -0500
Received: from smtp-server4.tampabay.rr.com ([65.32.1.43]:56012 "EHLO
	smtp-server4.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S266730AbSLPO0q>; Mon, 16 Dec 2002 09:26:46 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Dave Jones" <davej@codemonkey.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: /proc/cpuinfo and hyperthreading
Date: Mon, 16 Dec 2002 09:36:08 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJAELCDLAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20021216140809.GE11616@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Looks like you're either missing some ACPI config options, or
> you haven't updated the BIOS yet. On 2.5.51 with latest BIOS on
> the same box, I get..

Everything is fixed. No, I hadn't upgraded the BIOS; when I asked a contact
at Intel about the problem, I was told told me that BIOS was the latest.

I should have know better than to believe them!

Thank you very much; cat /proc/cpuinfo now reports two CPUs.

..Scott

