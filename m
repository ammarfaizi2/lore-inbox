Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267375AbTAMJF2>; Mon, 13 Jan 2003 04:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbTAMJF2>; Mon, 13 Jan 2003 04:05:28 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:14236 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S267375AbTAMJF1> convert rfc822-to-8bit; Mon, 13 Jan 2003 04:05:27 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH][COMPAT] compat_sys_[f]statfs - s390x part
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFC74FD0A9.9C22AA34-ONC1256CAD.0031FD29@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 13 Jan 2003 10:11:20 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 13/01/2003 10:13:56
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

> Hopefully, with Martin's continued blessing, here is the s390x part.

Looks fine to me. I can't test it at the moment because the s390x compat
stuff is broken right now. Not because of your patches but other things
need fixing. I'll have a go at it as soon as I'm through with the TLS
stuff for binutils and glibc. Keep up with it, I'm happy about every
line of code that is moved out of the arch/s390* folders.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


