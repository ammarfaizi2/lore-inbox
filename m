Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSILNjW>; Thu, 12 Sep 2002 09:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSILNjW>; Thu, 12 Sep 2002 09:39:22 -0400
Received: from ns1.mscsoftware.com ([192.207.69.10]:46834 "EHLO
	draco.macsch.com") by vger.kernel.org with ESMTP id <S315634AbSILNjV> convert rfc822-to-8bit;
	Thu, 12 Sep 2002 09:39:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Reply-To: martin.knoblauch@mscsoftware.com
Organization: MSC.Software GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: XFS?
Date: Thu, 12 Sep 2002 15:42:21 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209121542.21987.martin.knoblauch@mscsoftware.com>
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.15.0.1; VDF: 6.15.0.7
	 at mailmuc has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So does Redhat/Suse/??? ship XFS yet? 
>> 
>> john 
>> 
>
>Mandrake has had XFS support in the default boot kernel since 8.0. 
>AFAIK, Suse 
>and Slackware also have XFS capable kernels now too. 

 for what its worth, MSC.Linux supports it on IA32 and IA64 :-)

 In my opinion the non-inclosure in the mainline kernel is the most 
important reason not to use XFS (or any other FS). Which in turn 
massively reduces the tester base. It is a shame, because for some type 
of applications it performs great, or better than anything else.

Martin
-- 
Martin Knoblauch
Senior System Architect
MSC.software GmbH
Am Moosfeld 13
D-81829 Muenchen, Germany

e-mail: martin.knoblauch@mscsoftware.com
http://www.mscsoftware.com
Phone/Fax: +49-89-431987-189 / -7189
Mobile: +49-174-3069245

