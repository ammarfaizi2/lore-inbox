Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314727AbSEUPYB>; Tue, 21 May 2002 11:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314735AbSEUPYA>; Tue, 21 May 2002 11:24:00 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.94]:18181 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id <S314727AbSEUPX7> convert rfc822-to-8bit; Tue, 21 May 2002 11:23:59 -0400
Subject: RE: DCOM coming?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 21 May 2002 16:22:27 +0100
Message-ID: <541025071C7AC24C84E9F82296BB9B95080591@OPTEX1.optex.local>
X-MIMEOLE: Produced By Microsoft Exchange V6.0.4417.0
content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: DCOM coming?
Thread-Index: AcIA2oHhFnDDGyOmRpq8xIfliufRdQAAIxXA
From: "John Hall" <John.Hall@optionexist.co.uk>
To: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 May 2002 16:06 Wessler, Siegfried <Siegfried.Wessler@de.hbm.com>
wrote:

> If DCOM were wraped into the kernel, everyone could use it, as it
> would be a part of the os itself.

Something like DCOM does not belong in the kernel - it should be
implemented as a userspace library. The support in Microsoft Windows
AFAIK is implemented purely in userspace; Windows includes far more than
just a kernel.

Regards,
John
