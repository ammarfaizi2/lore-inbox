Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVG1OAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVG1OAe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVG1N6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:58:41 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:19882 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261255AbVG1N4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:56:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE;
  b=dWt98Qp5cY76BRVMvrSjQ2Fs0SZ2hWcsysK1KWrpBUss3yJtmxYdR/969QCx9MxNNecQf+7ypHHO6uexFl24A5TTIVPjppH/1IOQ9TsZORDLyR262pDTa3o7+PprGphUlJ/OQ0yYvP9Me24Wjig/0d1hU8N0wQUrPXQvb6PoaoM=  ;
Message-ID: <001e01c5937c$3553cf80$0801a8c0@SEBAS>
From: "gabri" <metadistros@yahoo.es>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <linux-kernel@vger.kernel.org>
References: <00ca01c592f2$da9eac60$0801a8c0@SEBAS> <20050728135234.GB31019@csclub.uwaterloo.ca>
Subject: Re: Helpme WitCh Cpu Scaling. Hi People
Date: Thu, 28 Jul 2005 15:56:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2.6.12.3 and 2.6.8 too
I hace amd mobile sempron 28000
----- Original Message ----- 
From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
To: "gabri" <metadistros@yahoo.es>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, July 28, 2005 3:52 PM
Subject: Re: Helpme WitCh Cpu Scaling. Hi People


> On Wed, Jul 27, 2005 at 11:33:36PM +0200, gabri wrote:
>> It is the first mail that I write. I call gabri and I am 18 years old. I 
>> am
>> Spanish. I want to comment that me program does not work ningun to 
>> regulate
>> the Mhz of the processor. " Cpufreq, cpuydn, powernow ". I do not manage 
>> to
>> load ningun module from the kernel inside cpuscalig in that it(he,she)
>> fences with an amd mobile sempron.
>> The modules of athlon do not go.
>> Do they work to give support to the mobile sempron in the future versions 
>> of
>> the kernel?
>> what can I do ?
>
> Is this your message?
> 08:44 < gabri> Jul 28 16:25:26 debian kernel: powernow-k8: Found 1 AMD 
> Athlon 64 / Opteron processors (version 1.00.09b)
> 08:45 < gabri> Jul 28 16:25:26 debian kernel: powernow-k8: BIOS error: 
> maxvid exceeded with pstate 0
>
> You should probably also list the kernel version(s) (uname -a) and cpuinfo
> (cat /proc/cpuinfo) just to have some more info to go on.
>
> I don't actually know anything about the cpu frequency scaling myself,
> since I just leave my systems running full speed all the time (I use
> desktop machines, not laptops).
>
> Len Sorensen 


		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es
