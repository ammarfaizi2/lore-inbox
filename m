Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292320AbSCRKiM>; Mon, 18 Mar 2002 05:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292530AbSCRKiC>; Mon, 18 Mar 2002 05:38:02 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:41411 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S292320AbSCRKhq> convert rfc822-to-8bit; Mon, 18 Mar 2002 05:37:46 -0500
From: "BOEBLINGEN LINUX390" <LINUX390@de.ibm.com>
Importance: Normal
Sensitivity: 
Subject: Re: Patch to fix s390 cross-compilation in 2.4.18
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF40A4953C.F18B14EE-ONC1256B80.003A4800@de.ibm.com>
Date: Mon, 18 Mar 2002 11:34:59 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 18/03/2002 11:37:37
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>It is required, because without it cpp blows up on assembler comments
>with special characters in them.
>
>Martin, did you apply the patch?
I did.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


