Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272451AbRIKOpQ>; Tue, 11 Sep 2001 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272510AbRIKOpL>; Tue, 11 Sep 2001 10:45:11 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:7184 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id <S272460AbRIKOoo>; Tue, 11 Sep 2001 10:44:44 -0400
Message-ID: <004d01c13ad0$86cbdb40$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "John Levon" <moz@compsoc.man.ac.uk>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010911020808.B88440@compsoc.man.ac.uk>
Subject: Re: serial overruns
Date: Tue, 11 Sep 2001 10:46:23 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John Levon" <moz@compsoc.man.ac.uk>
> I'm getting input overruns on a serial console with rates from 9600-38400
>
> The serial HOWTO suggests irqtune might be able to help with this problem
(which
> I really need to solve). Is there a 2.4 version available ? If not, would
updating
> irqtune and using it be likely to help ?

If you have an ide hard drive you may want to use hdparm to
make sure that it doesn't interfere too much. Please check
the archive for previous discussions on this.

..Stu


