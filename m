Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132307AbRAFQY7>; Sat, 6 Jan 2001 11:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131796AbRAFQYu>; Sat, 6 Jan 2001 11:24:50 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:13331 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S132305AbRAFQYk>; Sat, 6 Jan 2001 11:24:40 -0500
Date: Sat, 6 Jan 2001 08:23:50 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Mike <mike@khi.sdnpk.org>
cc: Igmar Palsenberg <maillist@chello.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Console logging
In-Reply-To: <Pine.LNX.4.21.0101061824460.7188-100000@server.serve.me.nl>
Message-ID: <Pine.LNX.4.30.0101060820160.30876-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Mike ,

On Sat, 6 Jan 2001, Igmar Palsenberg wrote:
> On Sat, 6 Jan 2001, Mike wrote:
> > Hi!
> > I am getting getting "/var/log/messages" on my console. It doesn't save
> > it in /var/log.
> > I have checked entries in /etc/syslog.conf file. Its correct.
> > Can someone help me.
> Syslog isn't running
	Or the directory/file in /var/log/ hasn't the correct permission
	to allow program 'X' to write into it .  But it is more likely
	that Igmar is correct .  Twyl ,  JimL

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
