Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267571AbSLMAi4>; Thu, 12 Dec 2002 19:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267572AbSLMAi4>; Thu, 12 Dec 2002 19:38:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46599 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267571AbSLMAiz>; Thu, 12 Dec 2002 19:38:55 -0500
Message-ID: <3DF8DD8E.8060406@zytor.com>
Date: Thu, 12 Dec 2002 11:03:42 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Terje Eggestad <terje.eggestad@scali.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Intel P6 vs P7 system call performance
References: <1039610907.25187.190.camel@pc-16.office.scali.no>	<3DF78911.5090107@zytor.com> 	<1039686176.25186.195.camel@pc-16.office.scali.no> <1039687609.1450.2.camel@laptop.fenrus.com>
In-Reply-To: <1039687609.1450.2.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Thu, 2002-12-12 at 10:42, Terje Eggestad wrote:
> 
> 
>>It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.
>>
>>For a simple op like that, even 11 is a lot... Really makes you wonder.
> 
> 
> wasn't rdtsc also supposed to be a pipeline sync of the cpu?
> (or am I confusing it with cpuid)

That's CPUID.

	-hpa

