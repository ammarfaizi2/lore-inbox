Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292328AbSBUKwu>; Thu, 21 Feb 2002 05:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292329AbSBUKwk>; Thu, 21 Feb 2002 05:52:40 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:56260 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S292328AbSBUKwY>; Thu, 21 Feb 2002 05:52:24 -0500
From: Christoph Rohland <cr@sap.com>
To: "Nadav Har'El" <nyh@math.technion.ac.il>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Elieser =?iso-8859-8-i?Q?Le=E3o?= <elieser@quatro.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Lucent WinModem
In-Reply-To: <3C73DC99.4030405@quatro.com.br>
	<E16daoj-0004D4-00@the-village.bc.nu>
	<20020221095513.GA7782@leeor.math.technion.ac.il>
Organisation: SAP LinuxLab
Date: Thu, 21 Feb 2002 11:51:26 +0100
In-Reply-To: <20020221095513.GA7782@leeor.math.technion.ac.il> ("Nadav
 Har'El"'s message of "Thu, 21 Feb 2002 11:55:13 +0200")
Message-ID: <m3r8nfqf9t.fsf@linux.wdf.sap-ag.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

On Thu, 21 Feb 2002, Nadav Har'El wrote:
> On Wed, Feb 20, 2002, Alan Cox wrote about "Re: Lucent WinModem":
> Actually, I think that Lucent's driver has been open source (I
> didn't check how "free" their license is) for at least a year
> now. No more of these ugly binary drivers that you had to apply
> binary patches (aggh!) to on every kernel version.

Nope, in the archive you will find a file ltmdmobj.o. The rest is a
wrapper for this binary only driver.

Greetings
		Christoph


