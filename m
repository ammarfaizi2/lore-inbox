Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133005AbRA3XG6>; Tue, 30 Jan 2001 18:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRA3XGs>; Tue, 30 Jan 2001 18:06:48 -0500
Received: from pcow028o.blueyonder.co.uk ([195.188.53.124]:2061 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S132946AbRA3XGj>;
	Tue, 30 Jan 2001 18:06:39 -0500
Date: Tue, 30 Jan 2001 23:06:33 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Multiple SCSI host adapters, naming of attached devices
Message-ID: <20010130230633.B388@kermit.wd21.co.uk>
In-Reply-To: <20010130224912.A388@kermit.wd21.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010130224912.A388@kermit.wd21.co.uk>; from michael@wd21.co.uk on Tue, Jan 30, 2001 at 22:49:12 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course I should have said this is linux kernel 2.2.17, an IBM PS/2 9585,
in-built 'IBM MCA' SCSI adapter and an AHA-1640 MCA card.

I now realise that in 2.4 I can use scsihosts=ibmmca:aha1542, but have no
info for 2.2.17.

Sorry for the lack of info previously :)

Thanks again.


On Tue, 30 Jan 2001 22:49:12 Michael Pacey wrote:
> Sorry for posting this here, I'm sure you're all busy with 2.4.1 and
> 2.2.18
> but I'm read the SCSI HOWTO and asked on #LinPeople to no avail:
> 
> Given two host adapters each with 1 disk of ID 0, how do I tell Linux
> which
> is sda and which sdb?
> 
> After this I'll be filling the 2nd SCSI chain completely, so assigning a
> different ID is not an option.
> 
> Thanks in advance.
> 
> --
> Michael Pacey
> michael@wd21.co.uk
> ICQ: 105498469
> 
> wd21 ltd - world domination in the 21st century
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
