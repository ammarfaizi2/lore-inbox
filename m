Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRLOA5D>; Fri, 14 Dec 2001 19:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281059AbRLOA4y>; Fri, 14 Dec 2001 19:56:54 -0500
Received: from ns.ithnet.com ([217.64.64.10]:56072 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S281024AbRLOA4n>;
	Fri, 14 Dec 2001 19:56:43 -0500
Date: Sat, 15 Dec 2001 01:56:35 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: G?rard Roudier <groudier@free.fr>
Cc: kirkalx@yahoo.co.nz, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-Id: <20011215015635.587b7ac2.skraw@ithnet.com>
In-Reply-To: <20011214172419.Q1591-100000@gerard>
In-Reply-To: <20011214041151.91557.qmail@web14904.mail.yahoo.com>
	<20011214172419.Q1591-100000@gerard>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001 17:46:37 +0100 (CET)
Gérard Roudier <groudier@free.fr> wrote:

> > My system is a clunky old Digital Pentium Pro with a
> > NCR53c810 rev 2 scsi controller, so it can't use the
> > sym driver.
> 
> Use sym53c8xx_2 instead. This one uses 2 different firmwares,
> [...]
> You may let me know if sym53c8xx_2 still works with 810 rev 2.

On my system it does. I have it as a second controller and am using sym-2
without troubles.

Regards,
Stephan


