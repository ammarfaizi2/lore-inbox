Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132604AbRDLCPd>; Wed, 11 Apr 2001 22:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132609AbRDLCPY>; Wed, 11 Apr 2001 22:15:24 -0400
Received: from phnxpop3.phnx.uswest.net ([206.80.192.3]:41483 "HELO
	phnxpop3.phnx.uswest.net") by vger.kernel.org with SMTP
	id <S132604AbRDLCPS>; Wed, 11 Apr 2001 22:15:18 -0400
Date: Wed, 11 Apr 2001 19:15:05 +0000
Message-ID: <3AD4AD39.6B070782@qwest.net>
From: "Art Wagner" <awagner@qwest.net>
To: "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac4-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Re: 8139too.c and 2.4.4-pre1 kernel burp
In-Reply-To: <3AD118F4.3050507@xmission.com> <3AD11A13.6E52A515@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff;
I am getting the same problem with 2.4.3-ac4.
See the attached messages log and system Information.
The problem seems to be traffic sensitive, with higher 
traffic between my system and the Cisco 675 DSL modem at
10.0.0.1.
Please let me know if I can provide any further useful
information.
Art Wagner

Jeff Garzik wrote:
> 
> Frank Jacobberger wrote:
> >
> > Jeff,
> >
> > I noticed the following on boot with 2.4.4-pre1:
> >
> > kernel: eth0: Too much work at interrupt, IntrStatus=0x0001.
> >
> > What is this saying to me :)
> 
> How often does this occur?  A lot, or just once or twice?
> 
> --
> Jeff Garzik       | Sam: "Mind if I drive?"
> Building 1024     | Max: "Not if you don't mind me clawing at the dash
> MandrakeSoft      |       and shrieking like a cheerleader."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
