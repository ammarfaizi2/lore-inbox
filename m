Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSEHT0V>; Wed, 8 May 2002 15:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314957AbSEHT0U>; Wed, 8 May 2002 15:26:20 -0400
Received: from fmr02.intel.com ([192.55.52.25]:57052 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S314938AbSEHT0T>; Wed, 8 May 2002 15:26:19 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7E25@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Santiago Nullo'" <sn@softhome.net>, linux-kernel@vger.kernel.org
Subject: RE: ACPI and swsusp in 2.4.19pre8-ac1
Date: Wed, 8 May 2002 12:26:14 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Santiago Nullo [mailto:sn@softhome.net] 
> There's an ACPI patch for 2.4.18 wich is newer and (in my 
> personall experience) better than the acpi code currently 
> used on the 2.4.19preX-acX series. Is there a reason for keep 
> this code instead of integrate the new code? Is swsusp one of them?

swsusp isn't the reason. We want to get the ACPI PCI routing issues worked
out before submitting for inclusion.

Regards -- Andy
