Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262398AbSJKLLV>; Fri, 11 Oct 2002 07:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbSJKLLU>; Fri, 11 Oct 2002 07:11:20 -0400
Received: from pizza.arcologie.net ([62.146.77.10]:60373 "EHLO
	pizza.arcologie.net") by vger.kernel.org with ESMTP
	id <S262398AbSJKLLU>; Fri, 11 Oct 2002 07:11:20 -0400
Subject: Re: Software-Raid: mark non-fresh disk as clean?
From: Falk Brockerhoff <falk@brockerhoff.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <15782.45472.274280.749816@notabene.cse.unsw.edu.au>
References: <1034334523.2361.15.camel@fairlight> 
	<15782.45472.274280.749816@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Oct 2002 13:21:39 +0200
Message-Id: <1034335303.2361.18.camel@fairlight>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fre, 2002-10-11 um 13.10 schrieb Neil Brown:

Hello,

> Get mdadm and use
> 
>    mdadm --assemble --force /dev/md0 /dev/hdk1 /dev/hdi1 /dev/hdg1  /dev/hde1

That's it! Thank you very much for your really fast answer ;-)

> NeilBrown

Regards,

Falk


