Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265259AbSIWJbU>; Mon, 23 Sep 2002 05:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSIWJbU>; Mon, 23 Sep 2002 05:31:20 -0400
Received: from 62-190-202-5.pdu.pipex.net ([62.190.202.5]:1540 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S265259AbSIWJbT>; Mon, 23 Sep 2002 05:31:19 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209230944.g8N9iN83000129@darkstar.example.net>
Subject: Re: hdparm -Y hangup
To: padraig.brady@corvil.com (Padraig Brady)
Date: Mon, 23 Sep 2002 10:44:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D8ED192.6060109@corvil.com> from "Padraig Brady" at Sep 23, 2002 09:32:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hrm, OK thanks for the info. Perhaps it should be removed
> from hdparm or a (DANGEROUS) put beside the description
> until it's fixed.

The person to contact would be Mark Lord, the hdparm maintainer, (see the hdparm manual page for his E-Mail address).

> > Incidently, I think you mean:
> > 
> > On RH7.3 (2.4.18-3) if I do:
> > $ hdparm -y /dev/hda
> > $ do stuff and disk spins up
> > $ hdparm -Y /dev/hda
> > $ everything hangs waiting for disk
> > 
> > with a lower case y for the first example.
> 
> No it seemed to wake up correctly the first time with -Y.

That *is* strange.

> As you say -y works always.

On the systems I have tried it, yes - I'm not saying it always works.

John.
