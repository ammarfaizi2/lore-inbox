Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280006AbRJ3QZ0>; Tue, 30 Oct 2001 11:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280005AbRJ3QZP>; Tue, 30 Oct 2001 11:25:15 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:49677 "HELO smeg")
	by vger.kernel.org with SMTP id <S280002AbRJ3QZI>;
	Tue, 30 Oct 2001 11:25:08 -0500
Message-ID: <14297.193.132.197.81.1004459024.squirrel@mail.mswinxp.net>
Date: Tue, 30 Oct 2001 16:23:44 -0000 (GMT)
Subject: Re: Still having problems with eepro100
From: "Lee Packham" <linux@mswinxp.net>
To: jo_ni@telia.com
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is inherent in FreeBSD, OpenBSD, NetBSD as well as Linux. I 
spent a few months hacking my Sony Vaio with number of OS's (it has this 
network card built onto it).

The problem is fatal unfortunately and the only solution I found was 
Intel's e100 driver.

'nuff said


Lee Packham

> 
> Hello,
> Does anyone except me still having problems with the eepro100 drivers ?
> 
> The network connection stalls and I'll get this message:
> 
> eepro100: wait_for_cmd_done timeout!
> 
> I am using the eepro100 drivers with my 100/10 card running in
> 10mbit and it works in windows.
> 
> I have been trying all new kernels + the ac patches but nothing
>seems to work. The fun thing is that I only gets this problem
> when I am running XFree, is this just a weird coincidence?
> 
> /Johan Nilsson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


