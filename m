Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270289AbRHMQZX>; Mon, 13 Aug 2001 12:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270280AbRHMQZN>; Mon, 13 Aug 2001 12:25:13 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:43462 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S270271AbRHMQZC>; Mon, 13 Aug 2001 12:25:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: Tom Gall <tom_gall@vnet.ibm.com>, alan@lxorguk.ukuu.org.uk,
        torvalds@transmeta.com
Subject: Re: ppc64 submission
Date: Mon, 13 Aug 2001 10:28:10 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, esr@thyrsus.com
In-Reply-To: <3B77F5CF.5C3CF66D@vnet.ibm.com>
In-Reply-To: <3B77F5CF.5C3CF66D@vnet.ibm.com>
MIME-Version: 1.0
Message-Id: <0108131028100D.30719@spc2.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 August 2001 09:44, Tom Gall wrote:
> Greetings,
>
>   Located on kernel.org in pub/linux/kernel/people/tgall/ you will find
> linuxppc64-2.4.8-1.patch.gz. Please consider this for inclusion into the
> linux kernel sources. It applies against 2.4.8 as the name suggests.
>
[snipped]
>   Any questions by all means please hollar!

Just one comment. I looked at this, and the following config options are
added, but don't have Configure.help entries, so this is a "heads-up" that
help texts for the following may eventually be needed.

CONFIG_ISTAR
CONFIG_KDB
CONFIG_KDB_OFF
CONFIG_MOTOROLA_HOTSWAP
CONFIG_MSCHUNKS
CONFIG_PPCDBG
CONFIG_PPC_ISERIES

Thanks in advance,
Steven
