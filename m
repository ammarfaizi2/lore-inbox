Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751136AbWFEOVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFEOVS (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWFEOVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:21:18 -0400
Received: from spirit.analogic.com ([204.178.40.4]:62733 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751127AbWFEOVQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:21:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 05 Jun 2006 14:21:15.0402 (UTC) FILETIME=[4DE116A0:01C688AB]
Content-class: urn:content-classes:message
Subject: Re: Linux kernel and laws
Date: Mon, 5 Jun 2006 10:21:15 -0400
Message-ID: <Pine.LNX.4.61.0606051006030.17323@chaos.analogic.com>
In-reply-to: <20060605140226.GR3955@stusta.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux kernel and laws
Thread-Index: AcaIq03qCm7Z3UfwQuySzIAL9A+Pbg==
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060605085451.GA26766@infradead.org> <20060605123304.GA6066@havoc.gtf.org> <1149511707.3111.57.camel@laptopd505.fenrus.org> <20060605125235.GB6066@havoc.gtf.org> <20060605140226.GR3955@stusta.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: "Jeff Garzik" <jeff@garzik.org>, "Arjan van de Ven" <arjan@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linville@tuxdriver.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Jun 2006, Adrian Bunk wrote:

> On Mon, Jun 05, 2006 at 08:52:35AM -0400, Jeff Garzik wrote:
>> ...
>>> Paying attention to proper reverse engineering is good. Being
>>> overzealous is not.
>>
>> Being overzealous about merging drivers without first checking the legal
>> ramifications is a good way to torpedo Linux.
>>
>> Far too many people have a careless "U.S.A. laws suck, merge it anyway"
>> attitude.
>
> Independent of this issue:
>
> An interesting question is how to handle legal issues properly.
>
> Where is the borderline for rejecting code due to legal issues?
> Might not be 100% correct according to laws in the USA.
> Might not be 100% correct according to laws in Germany.
> Might not be 100% correct according to laws in Finland.
> Might not be 100% correct according to laws in Norway.
> Might not be 100% correct according to laws in Brasil.
> Might not be 100% correct according to laws in Japan.
> Might not be 100% correct according to laws in India.
> Might not be 100% correct according to laws in Russia.
> Might not be 100% correct according to laws in China.
> Might not be 100% correct according to laws in Saudi Arabia.
> Might not be 100% correct according to laws in Iran.
>
> For me living in Germany, none of these laws except for the German one
> has any relevance.
>
> I've never seen people on this list pointing to probable problems with
> Chinese laws although these laws are relevant for four times as many
> people as US laws.
>
> If someone would state a submission to the kernel might have issues
> according to Chinese laws, or Iranian laws, or Russian laws, would this
> be enough for keeping code out of the kernel?
>
> This might sound like a theoretical question, but e.g. considering that
> the kernel contains cryptography code it's a question that might have
> wide practical implications.
>
>> 	Jeff
>
> cu
> Adrian

If the kernel represented simply a knowledge base, then the burden
about whether or not someone could use it used to rest entirely
upon the user. That's why some Pacific rim governments are reportedly
fire-walling information.

In most western cultures, knowledge was not a crime. For many years,
someone could write a book, telling you how to kill somebody and,
as long as he didn't carry it out, he could not be held culpable.

Recently, in the US and some other countries, knowledge has become
criminalized. If you know how to defeat copy protection, and
you are not in a protected industry, you could be tried and
convicted of a federal crime.

That's one of the reasons why there are now no general guidelines
about kernel code, or any intellectual property use, for that matter.
The conditions could occur where the government thinks that you
know too much and are, therefore, a threat to "national security".

So, again, see a lawyer. The fact that you sought and accepted
legal opinion may in the future be your only viable defense as
governments bring charges against you! Sorry state of affairs for
sure.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.88 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
