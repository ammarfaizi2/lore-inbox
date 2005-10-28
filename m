Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965054AbVJ1Cf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbVJ1Cf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 22:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVJ1Cf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 22:35:57 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:9733 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965054AbVJ1Cf4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 22:35:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NGy4fVfX4P+hI4tZXcppUrzvMs6TKYXzblSbRstOxufNOy8U6V+G/GFYs3iCSk9DkyThj9xWStYr1Max7BqB1c+OTvrfQr0XYP2soEM8EsMfYlLoJYQm8utNuhDuA9yFOku9I3QtChD/raFmfZNYCbogBR2/lBi7ZqTavjx9uqY=
Message-ID: <1e62d1370510271935o51d88c0bk7baa23ca1a75bc4d@mail.gmail.com>
Date: Fri, 28 Oct 2005 07:35:56 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Subject: Re: 4GB memory and Intel Dual-Core system
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051027211203.M33358@linuxwireless.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com>
	 <20051027204923.M89071@linuxwireless.org>
	 <1130446667.5416.14.camel@blade>
	 <20051027205921.M81949@linuxwireless.org>
	 <1130447261.5416.20.camel@blade>
	 <20051027211203.M33358@linuxwireless.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> On Thu, 27 Oct 2005 23:07:41 +0200, Marcel Holtmann wrote
> > Hi Alejandro,
> >
> > so there is no way to give me back the "lost" memory. Is it possible
> > that another motherboard might help?
>
> AFAIK, No. AMD and Intel will always do the same thing until we all move to
> real IA64.
>

Can you tell me the main differences between IA64 and x86_64 (Opteron)
? because in your one of the previous mail you said IA64 != EM64T and
its true, but I know is EM64T/AMD64 in 64-bit mode != IA32 but you
said that too EM64T is not really 64-bit, its a IA32 .. Can you give
me some link which just tells the difference between IA64 (Itanium)
and AMD64 (Opteron) ?

While googling I found this article
http://www.eweek.com/article2/0,1895,1046390,00.asp but its not
clearing mentioning the difference between Opteron and Itanium !

Although I found this difference in that article :
                     With the Itanium, Intel proposes to examine
programs when they are compiled into their executable form and encode
concurrent operations ahead of time. Intel calls this approach EPIC,
for Explicitly Parallel Instruction Computing, and it is the genuine
difference between the Itanium and AMD's x86-64. EPIC's drawback is
that the core of the Itanium no longer offers an effective
upward-compatible path to existing x86 code; its speed in running that
32-bit code has proved to be disappointing.

So is there any other difference except above ?


--
Fawad Lateef
