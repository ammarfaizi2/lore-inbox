Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSHUP0M>; Wed, 21 Aug 2002 11:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSHUP0M>; Wed, 21 Aug 2002 11:26:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:32495 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318153AbSHUP0L>; Wed, 21 Aug 2002 11:26:11 -0400
Subject: Re: oops while fixating cd-r: 2.4.18,aha152x,phillips cdd2600
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: bd@bc-bd.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020821171640.GE709@hexenkessel.bc>
References: <20020821171640.GE709@hexenkessel.bc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 16:31:15 +0100
Message-Id: <1029943875.26425.89.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 18:16, bd@bc-bd.org wrote:
> i can reproduce an oops on 2.4.18 when trying to fixate a CD-R. i use
> the Phillips CD2600 CD-Writer attached to an old ISA aha1510 SCSI card.
> cdrecord was used (1.10) to create the cd.

The 2.4.18 case isnt interesting

> the oops's are from my i586 machine, running debian/testing. i can not
> test this issue wihh the 2.4.19 kernel, since it hangs on boottime
> during partitionchecking, even with -ac4.

Thats a seperate thing we need to resolve and first. The CD stuff should
be sorted.

