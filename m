Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272235AbRIESWc>; Wed, 5 Sep 2001 14:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272241AbRIESWX>; Wed, 5 Sep 2001 14:22:23 -0400
Received: from [216.102.46.130] ([216.102.46.130]:52269 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S272235AbRIESWI>; Wed, 5 Sep 2001 14:22:08 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: iSCSI support for Linux??
In-Reply-To: <3B966B19.9558DA58@candelatech.com>
From: Roland Dreier <roland@topspincom.com>
Date: 05 Sep 2001 11:22:03 -0700
In-Reply-To: Ben Greear's message of "Wed, 05 Sep 2001 11:12:41 -0700"
Message-ID: <52heuhjy5w.fsf@love-boat.topspincom.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ben> Does anyone know of any efforts to support iSCSI in Linux?

I know of three iSCSI initiator (ie host-side, not storage-side)
software projects:

  Cisco: <http://linux-iscsi.sourceforge.net/>
  Intel: <http://sourceforge.net/projects/intel-iscsi/>
  UNH:   <http://www.cs.uml.edu/~mbrown/iSCSI/

Cisco's and UNH's software is GPLed, Intel is using a BSD-type
license.

Roland
