Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136034AbRD0Nqk>; Fri, 27 Apr 2001 09:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136035AbRD0Nq3>; Fri, 27 Apr 2001 09:46:29 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:1513 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S136034AbRD0NqY>; Fri, 27 Apr 2001 09:46:24 -0400
From: Christoph Rohland <cr@sap.com>
To: "mirabilos" <eccesys@topmail.de>
Cc: <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <3AE879AE.387D3B78@antefacto.com>
	<Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
	<20010426223950.C3683@l-t.ee> <9caevn$65j$1@cesium.transmeta.com>
	<025f01c0cf0e$5feb1eb0$de00a8c0@homeip.net>
Organisation: SAP LinuxLab
Date: 27 Apr 2001 15:41:35 +0200
In-Reply-To: <025f01c0cf0e$5feb1eb0$de00a8c0@homeip.net>
Message-ID: <m34rvah33k.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, eccesys@topmail.de wrote:
>> > tmpfs is basically ramfs with limits.
>> > 
>> 
>> ... and swappable.
>> 
>> -hpa
> 
> Hmmm and what's shmfs? Precedessor of tmpfs?

Yes.

> I even cant remember which one I use for /tmp ;-)

You can mount tmpfs also with type "shm" for compatibility. Type "shm"
will be marked as obsolete in 2.5

Greetings
		Christoph


