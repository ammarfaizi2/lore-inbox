Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbRBLRB2>; Mon, 12 Feb 2001 12:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129698AbRBLRBS>; Mon, 12 Feb 2001 12:01:18 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:34654 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129614AbRBLRBH>; Mon, 12 Feb 2001 12:01:07 -0500
Date: Mon, 12 Feb 2001 06:57:20 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1: Abnormal interrupt from RTL8139
Message-ID: <20010212065720.A1120@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010208093854.A1122@christian.chrullrich.de> <3A874CB4.717C101C@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
In-Reply-To: <3A874CB4.717C101C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Feb 11, 2001 at 09:38:44PM -0500
X-M$-Free-System: since 1999-11-28
X-Current-Uptime: 0 d, 00:01:33 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik wrote on Sunday, 2001-02-11:

> Christian Ullrich wrote:

> > I'm getting some of these messages in syslog:
> > Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
> > Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000010.
> > Feb  6 07:38:35 christian kernel: eth0: Abnormal interrupt, status 00000020.
> > Feb  7 17:32:53 christian kernel: eth0: Abnormal interrupt, status 00000041.
> [...]
> > I have not observed any effects related to these messages.
> 
> Those messages are logged at the debugging level... if they bother you,
> don't log kern.debug...

Well, doing something related to debugging implies that there _is_
something to debug. But since I don't have any problems and not
more than a few messages like these, thanks for your help.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
