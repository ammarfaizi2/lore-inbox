Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264500AbSIQTZ2>; Tue, 17 Sep 2002 15:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264509AbSIQTZ2>; Tue, 17 Sep 2002 15:25:28 -0400
Received: from 62-190-218-75.pdu.pipex.net ([62.190.218.75]:57354 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S264500AbSIQTZ1>; Tue, 17 Sep 2002 15:25:27 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209171930.g8HJU8XO004127@darkstar.example.net>
Subject: Re: Hi is this critical??
To: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 17 Sep 2002 20:30:08 +0100 (BST)
Cc: andre@linux-ide.org, alan@lxorguk.ukuu.org.uk,
       nuitari@balthasar.nuitari.net, venom@sns.it,
       linux-kernel@vger.kernel.org, xavier.bestel@free.fr, mark@veltzer.org
In-Reply-To: <20020917185440.C29890@flint.arm.linux.org.uk> from "Russell King" at Sep 17, 2002 06:54:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Sep 17, 2002 at 10:34:10AM -0700, Andre Hedrick wrote:
> > Quietly it is the SHIPPER's Test.
> > 
> > There should be an appilcation you run when you get the device.
> > If you fail to run it when you get first powerup the device, you are at
> > fault.  To many devices have been smoked in shipping.
> 
> Umm, that's crap.  If the program is an x86 binary, I don't have
> the facilities to run it here.

No, it's not an x86 binary, it's in the firmware of the drive:

Execute Extended Self Test

smartctl -x /dev/hda?

so if you can send a S.M.A.R.T. command, you can run the test.

> Its their problem.  Its a crap system.  Period.

No, I don't think that you can expect drive manufacturers to replace a disc that you haven't taken care of, especially if it has been used as a football, (isn't that against FIFA regulations, though?  Especially in the world cup example given earlier in this thread.  I thought the specs of the football were quite strict).

John.
