Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283097AbRLIHA6>; Sun, 9 Dec 2001 02:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283135AbRLIHAt>; Sun, 9 Dec 2001 02:00:49 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63755 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283097AbRLIHAh>;
	Sun, 9 Dec 2001 02:00:37 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: torvalds@transmeta.com, ankry@mif.pg.gda.pl, axboe@suse.de,
        linux-kernel@vger.kernel.org, pat@it.com.au, tfries@umr.edu
Subject: Re: PATCH: linux-2.5.1-pre7/drivers/block/xd.c compilation fix (version 2) 
In-Reply-To: Your message of "Sat, 08 Dec 2001 22:06:57 -0800."
             <200112090606.WAA07320@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Dec 2001 18:00:20 +1100
Message-ID: <18864.1007881220@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001 22:06:57 -0800, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	Anyhow, thanks for asking.  By the way, if you have any interest
>in integrating my "./configure" functionality now, I would be happy to
>clean it up and resubmit it.  (It is mostly a patch to scripts/Configure.)

Already in kbuild 2.5, it supports make allyes, allno, allmod, random.

