Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274863AbTHKWSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274866AbTHKWSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:18:33 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:52242 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S274863AbTHKWS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:18:27 -0400
Date: Mon, 11 Aug 2003 19:18:33 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Jens Benecke <usenet@jensbenecke.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-rc2
Message-Id: <20030811191833.76cbbc6d.vmlinuz386@yahoo.com.ar>
In-Reply-To: <bh8vv8$3qc$1@sea.gmane.org>
References: <Pine.LNX.4.44.0308081751390.10734-100000@logos.cnet>
	<bh8vv8$3qc$1@sea.gmane.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003 22:57:21 +0200, Jens Benecke wrote:
>Marcelo Tosatti wrote:
>
>> Here goes release candidate 2.
>> It contains yet another bunch of important fixes, detailed below.
>> Nice weekend for all of you!
>
>I'm having problems.  had them with -pre10 as well, posted here, but
>th= ey
>somehow didn't appear in the list.
>
>Here's the short story: No network (3c509) because the card gets IRQ
>22=
> (or
>something) and doesn't like it, no USB, no firewire, no X11 (yeah,
>shou= ld
>have recompiled the NVIDIA drivers, duh), and a total crash on
>shutdown=-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

try with option "noapic" at boot time.

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
