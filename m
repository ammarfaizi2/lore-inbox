Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278810AbRK1Rmr>; Wed, 28 Nov 2001 12:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278818AbRK1Rmh>; Wed, 28 Nov 2001 12:42:37 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:19885 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S277371AbRK1Rmd>; Wed, 28 Nov 2001 12:42:33 -0500
From: Christoph Rohland <cr@sap.com>
To: Padraig Brady <padraig@antefacto.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Documentation/filesystems/tmpfs
In-Reply-To: <m3y9kqon6w.fsf@linux.local> <3C051F2D.2030804@antefacto.com>
Organisation: SAP LinuxLab
Date: 28 Nov 2001 18:37:46 +0100
In-Reply-To: <3C051F2D.2030804@antefacto.com>
Message-ID: <m3u1veokyd.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Padraig,

On Wed, 28 Nov 2001, Padraig Brady wrote:
>> In contrast to RAM disks, which get allocated a fixed amount of
>> physical RAM, tmpfs grows and shrinks to accommodate the files it
>> contains and is able to swap unneeded pages out to swap space.
> 
> 
> 
> That isn't the case now since ramdisks were integrated with the
> buffer cache:

What isn't the case any more?

> $ dd if=/dev/zero of=/tmp/use_mem bs=1024 count=20000

On what filesystem is /tmp/use_mem located? What do you want to show?

Greetings
		Christoph


