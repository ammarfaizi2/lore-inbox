Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287607AbSAXMJD>; Thu, 24 Jan 2002 07:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287612AbSAXMIn>; Thu, 24 Jan 2002 07:08:43 -0500
Received: from [195.66.192.167] ([195.66.192.167]:18957 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S287607AbSAXMIg>; Thu, 24 Jan 2002 07:08:36 -0500
Message-Id: <200201241206.g0OC66E10502@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="koi8-r"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: info@global-digicom.com
Subject: Re: White Paper on the Linux kernel VM?
Date: Thu, 24 Jan 2002 14:06:04 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020124033618.20653.cpmta@c001.snv.cp.net>
In-Reply-To: <20020124033618.20653.cpmta@c001.snv.cp.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 January 2002 01:36, info@global-digicom.com wrote:
> I am interested in reviewing the technical specifications on the Linux
> kernel VM. As there has been much controversy of late on this subject, it
> would be relevant to compare the concepts behind both the former VM and the
> new VM in order to obtain a better understanding of the issues. Is there a
> “white paper” available on both the old and the new VM’s? Understandably,
> the VM is a work in progress; however, there should be a basic set of
> design goals and concepts from which future development will proceed.  It
> would definitely be helpful to present them both as an aid to further
> analysis.

It was said that code is sufficient, you can read it and ask questions on 
lkml if you will find difficult to swallow parts. You may spot some bugs 
also, that will be very good! Linux kernel needs peer review!

Writing docs wastes developer's time: they will write how they want VM to 
operate or how they think it operates (while some bug can make actual VM 
operate differently) instead of improving/debugging current VM code.

After you got to understand how Linux VM works from source, feel free to 
write docs.

Yes, it is not an easy path to VM doc. :-)
I must say I did not do it (yet?).
--
vda
