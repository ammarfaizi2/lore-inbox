Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311026AbSCHTHj>; Fri, 8 Mar 2002 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311024AbSCHTH3>; Fri, 8 Mar 2002 14:07:29 -0500
Received: from miranda.axis.se ([193.13.178.2]:46023 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S311018AbSCHTHW>;
	Fri, 8 Mar 2002 14:07:22 -0500
From: johan.adolfsson@axis.com
Message-ID: <025b01c1c6d4$63c05500$aab270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: <root@chaos.analogic.com>, "Jamie Lokier" <lk@tantalophile.demon.co.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
        "Terje Eggestad" <terje.eggestad@scali.com>,
        "Ben Greear" <greearb@candelatech.com>,
        "Davide Libenzi" <davidel@xmailserver.org>,
        "george anzinger" <george@mvista.com>
In-Reply-To: <Pine.LNX.3.95.1020308134552.6627A-100000@chaos.analogic.com>
Subject: Re: gettimeofday() system call timing curiosity
Date: Fri, 8 Mar 2002 20:06:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What happens if you remove the printf/puts and simply counts the number
of times the different cases happen?

Another thought: Isn't it quite common that clock generators has a mode
where the frequency differs around the desired frequency to spread the
spectrum
and easier pass EMC tests?
Could that be the case with the laptop?
/Johan

