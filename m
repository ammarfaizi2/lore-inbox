Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263048AbSJBL0L>; Wed, 2 Oct 2002 07:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263050AbSJBL0L>; Wed, 2 Oct 2002 07:26:11 -0400
Received: from ulima.unil.ch ([130.223.144.143]:38817 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S263048AbSJBL0K>;
	Wed, 2 Oct 2002 07:26:10 -0400
Date: Wed, 2 Oct 2002 13:31:38 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi ooops with 2.5.40 (PIIX4 and DVD)
Message-ID: <20021002113138.GC3247@ulima.unil.ch>
References: <E17wfyp-00063r-00@rammstein.mweb.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E17wfyp-00063r-00@rammstein.mweb.co.za>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 09:49:23AM +0000, bonganilinux@mweb.co.za wrote:

> It's actually not an Ooops it is some debug code to capture code
> which is doing the wrong thing. Dont worry about it.

OK, unfortunately, the result is that my DVD-rom is not accesible...

> This is what I am worried about, I also saw this at my home PC, but
> doing cdrecord -scanbus does pick up my cdwiter.

cdrecord -scanbus:
Cdrecord 1.11a26 (i586-mandrake-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
cdrecord: No such file or directory. Cannot open '/dev/pg*'. Cannot open SCSI driver.
cdrecord: For possible targets try 'cdrecord -scanbus'. Make sure you are root.

> BTW: Thanx to whoever fixed ide-scsi I can now boot without getting an
> Oops (that I reported in 2.5.39). Now I seem to have lost the mouse
> but I will look ate that when I get back home.

I don't know if it really an ide-scsi related problem, but I like to be
able to hear music while working...

Thank for your answer,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
