Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271201AbTHRDJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 23:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271205AbTHRDJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 23:09:26 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:55054 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271201AbTHRDJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 23:09:24 -0400
Date: Mon, 18 Aug 2003 00:07:47 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc2-ac3
Message-Id: <20030818000747.60b8cf17.vmlinuz386@yahoo.com.ar>
In-Reply-To: <200308162139.h7GLdW415121@devserv.devel.redhat.com>
References: <200308162139.h7GLdW415121@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 17:39:32 -0400 (EDT), Alan Cox wrote:
>Linux 2.4.22-rc2-ac3
>o	Finish off the core IDE hotplug support		(me)
>	| If your hardware supports it you can now
>	| hdparm -b0 /dev/hdc  change drive hdparm -b1 /dev/hdc
>o	Fix problem with wan Config.in			(Adrian Bunk)
>o	Fix NTFS warnings				(Gerardo Exequiel Pozzi)
>o	Add a 3com ident to the tulip driver		(Ion Badulescu)
>o	Clip drives when LBA48 isn't available		(Jan Niehusmann, 
>							 Andries Brouwer)
>o	Update megaraid2 driver				(Atul Mukker, Haruo
>							 Tomita)
>	| Plus remove some escaped volatiles
>

nice,! thank you very much to consider my patch,

at the moment I am proving ac3 like with the previous ones in my system,
and everything works perfect.

PD: I am working at the moment to correct all warnings __ FUNCTION __
that finds (1500).


chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
