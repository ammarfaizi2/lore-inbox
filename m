Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289702AbSAOWRO>; Tue, 15 Jan 2002 17:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289704AbSAOWRE>; Tue, 15 Jan 2002 17:17:04 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:33803 "EHLO
	apone.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S289702AbSAOWRA>; Tue, 15 Jan 2002 17:17:00 -0500
Date: Tue, 15 Jan 2002 17:23:16 -0500
From: Bill Nottingham <notting@redhat.com>
To: "David C. Hansen" <haveblue@us.ibm.com>
Cc: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] cs46xx: sound distortion after hours of use
Message-ID: <20020115172316.B10525@apone.devel.redhat.com>
Mail-Followup-To: "David C. Hansen" <haveblue@us.ibm.com>,
	Erik Mouw <J.A.K.Mouw@its.tudelft.nl>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200201151224.g0FCO8E06163@Port.imtp.ilyichevsk.odessa.ua> <20020115152000.GD13196@arthur.ubicom.tudelft.nl> <3C4482A2.8040903@us.ibm.com> <20020115153439.A413@davetop.uacdd.wvu.edu> <3C449426.6000300@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C449426.6000300@us.ibm.com>; from haveblue@us.ibm.com on Tue, Jan 15, 2002 at 12:42:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David C. Hansen (haveblue@us.ibm.com) said: 
> BTW, I have a Thinkpad T21.  Do any of you have a non-IBM notebook?

I have an IBM notebook and I see it from time to time. If I had to guess,
it's probably related to the powersaving stuff. (That seems to be the
common-to-IBM quirk for cs46xx. ;) )

Bill
