Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266669AbRGEI4b>; Thu, 5 Jul 2001 04:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266674AbRGEI4V>; Thu, 5 Jul 2001 04:56:21 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:20155 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S266669AbRGEI4L> convert rfc822-to-8bit; Thu, 5 Jul 2001 04:56:11 -0400
Importance: Normal
Subject: Re: N_HCI for S390x missing in 2.4.5
To: Andreas Jaeger <aj@suse.de>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFC63A8547.BBFA5915-ONC1256A80.00307145@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 5 Jul 2001 10:51:31 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 05/07/2001 10:54:05
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Looking at the patch for 2.4.5, I noticed that all architectures use
>N_HCI - except s390x which has N_BT.
>
>Why is this different?  I propose to use N_HCI everywhere,

It should not be different for s390x. Probably a typo. I will fix it
and the patch will go out with the next update.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


