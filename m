Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272667AbRIGOLU>; Fri, 7 Sep 2001 10:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272668AbRIGOLK>; Fri, 7 Sep 2001 10:11:10 -0400
Received: from inetc.connecttech.com ([64.7.140.42]:10763 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id <S272667AbRIGOK7>; Fri, 7 Sep 2001 10:10:59 -0400
Message-ID: <03ca01c137a7$1a6e8000$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Stephen Torri" <storri@ameritech.net>, "D. Stimits" <stimits@idcomm.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109061624320.1443-100000@base.torri.linux>
Subject: Re: Serial Ports
Date: Fri, 7 Sep 2001 10:12:18 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Stephen Torri" <storri@ameritech.net>
> I have noticed that serial ports change IRQ to either 3 or 4. There is no
> reason for this behavior. I have created a perl script to create a log
> containing the irqs assigned and their ioports. Is there anything else I
> could log that might unmask the problem?

Try posting the contents of /proc/irqs and /proc/ioports, perhaps
someone here will see something you don't.

..Stu


