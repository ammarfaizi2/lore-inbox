Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278385AbRJWXiS>; Tue, 23 Oct 2001 19:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278387AbRJWXiI>; Tue, 23 Oct 2001 19:38:08 -0400
Received: from freeside.toyota.com ([63.87.74.7]:32274 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S278385AbRJWXiA>;
	Tue, 23 Oct 2001 19:38:00 -0400
Message-ID: <3BD5FF73.167A969C@lexus.com>
Date: Tue, 23 Oct 2001 16:38:27 -0700
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Gluck <jgluckca@home.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: OT: Problem compiling read_cdda-2.05
In-Reply-To: <3BD5FD1E.D4EB7649@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gluck wrote:

> Hi
>
> Sorry for posting this here. I tried e-mailing the authir but the mail
> got bounced.
>
> I am trying to get this to compile.
> I get the following errors:
>
> In file included from read_cdda.c:71:
> read_cdda.h:45: sys/cdio.h: No such file or directory
> In file included from read_cdda.c:71:
> read_cdda.h:50: sys/scsi/impl/uscsi.h: No such file or directory

Do you have kernel headers installed?

cu

jjs


