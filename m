Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289738AbSBNFKb>; Thu, 14 Feb 2002 00:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289741AbSBNFKW>; Thu, 14 Feb 2002 00:10:22 -0500
Received: from defiant.secureone.com.au ([203.55.158.195]:41382 "EHLO
	defiant.secureone.com.au") by vger.kernel.org with ESMTP
	id <S289738AbSBNFKH>; Thu, 14 Feb 2002 00:10:07 -0500
Posted-Date: Thu, 14 Feb 2002 15:10:36 +1000
X-URL: SecureONE SecureSentry - http://www.secureone.com.au/
Message-ID: <044001c1b516$66c662f0$0f01000a@brisbane.hatfields.com.au>
Reply-To: "Andrew Hatfield" <lkml@secureone.com.au>
From: "Andrew Hatfield" <lkml@secureone.com.au>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>
Subject: Re: Linux 2.4.18-pre9-mjc2
Date: Thu, 14 Feb 2002 15:12:53 +1000
Organization: SecureONE
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Reverse Mapping VM Patch #12e (Rik van Riel)

Except that Documentation/vm/Changelog.rmap still reports...

rmap 12a:
  - fix the compile warning in buffer.c                   (me)
  - fix divide-by-zero on highmem initialisation  DOH!    (me)
  - remove the pgd quicklist (suspicious ...)             (DaveM, me)


This is confusing to people.  is 12e applied??

  --

  Andrew Hatfield
  SecureONE - http://www.secureone.com.au/
  President - South East Brisbane Linux Users Group  http://www.seblug.org/

  Kernel work available at http://development.secureone.com.au/kernel/


