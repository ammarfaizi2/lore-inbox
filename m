Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSLJQ21>; Tue, 10 Dec 2002 11:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSLJQ21>; Tue, 10 Dec 2002 11:28:27 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:13760 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262662AbSLJQ21>; Tue, 10 Dec 2002 11:28:27 -0500
Subject: Re: IDE feature request & problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: Petr Sebor <petr@scssoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <021401c2a05d$f1c72c80$551b71c3@krlis>
References: <068d01c29d97$f8b92160$551b71c3@krlis>
	<1039312135.27904.11.camel@irongate.swansea.linux.org.uk>
	<20021208234102.GA8293@scssoft.com>  <021401c2a05d$f1c72c80$551b71c3@krlis>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 17:10:02 +0000
Message-Id: <1039540202.14251.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 15:07, Milan Roubal wrote:
> DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
> AddrMarkNotFound }, LBAsect=8830595334015, high=526344, low=8355711,
> sector=196817664

Can you force an fsck of the volume firstly. AddrMark not found isnt too
nreasonable a compliant given the LBAsect in question

