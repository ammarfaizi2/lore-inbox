Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288578AbSADKRN>; Fri, 4 Jan 2002 05:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288576AbSADKRD>; Fri, 4 Jan 2002 05:17:03 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:17568 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S288590AbSADKQz>; Fri, 4 Jan 2002 05:16:55 -0500
Message-ID: <001e01c19508$ee319b70$140ba8c0@mistral>
From: "Simon Turvey" <turveysp@ntlworld.com>
To: "SATHISH.J" <sathish.j@tatainfotech.com>,
        "kernelnewbies" <kernelnewbies@nl.linux.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10201041427001.2221-100000@blrmail>
Subject: Re: How to take a crash dump
Date: Fri, 4 Jan 2002 10:16:52 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have "lcrash" installed on my system. I have 2.4.8 kernel. I would like
> to know how to make a linux system panic so that I can take a crash dump
> and analyse using "lcrash". Is there any command to make the system panis
> as we have on other unices(SVR4 and unixware)?

Try dereferencing a null pointer.  Works for me, intentionally or otherwise
:)

All the best,
    Simon

----- Original Message -----
From: "SATHISH.J" <sathish.j@tatainfotech.com>
To: "kernelnewbies" <kernelnewbies@nl.linux.org>; "linux-kernel"
<linux-kernel@vger.kernel.org>; "linux india programming"
<linux-india-programmers@lists.sourceforge.net>
Sent: Friday, January 04, 2002 9:00 AM
Subject: How to take a crash dump


> Hi,
>
> I have "lcrash" installed on my system. I have 2.4.8 kernel. I would like
> to know how to make a linux system panic so that I can take a crash dump
> and analyse using "lcrash". Is there any command to make the system panis
> as we have on other unices(SVR4 and unixware)?
>
> Thanks in advance,
>
>
> Warm regards,
> Sathish.J
> Systems Engineer
> Tata Infotech Limited
> 80 Feet Road
> Indra Nagar
> Bangalore-560 038.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


