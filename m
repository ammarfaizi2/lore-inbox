Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269924AbRHJHBa>; Fri, 10 Aug 2001 03:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269925AbRHJHBU>; Fri, 10 Aug 2001 03:01:20 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:44465 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S269924AbRHJHBJ> convert rfc822-to-8bit; Fri, 10 Aug 2001 03:01:09 -0400
Importance: Normal
Subject: Re: Debugging help: BUG: Assertion failure with ext3-0.95 for 2.4.7
To: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org, arjanv@redhat.com,
        trini@kernel.crashing.org, "Carsten Otte" <COTTE@de.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFBA502D7F.238E76F1-ONC1256AA4.00261CEE@de.ibm.com>
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Date: Fri, 10 Aug 2001 09:00:59 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 10/08/2001 09:00:27
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Congratulations,

it seems that your endian bug fix solved my problems. Until now I could not
reproduce this problem any more. I will do some more tests, but I think
that this fix should become part of the next ext3-prerelease.


--
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49 7031-16-3507


