Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbTASPQA>; Sun, 19 Jan 2003 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267619AbTASPQA>; Sun, 19 Jan 2003 10:16:00 -0500
Received: from ulima.unil.ch ([130.223.144.143]:17088 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S267541AbTASPP7>;
	Sun, 19 Jan 2003 10:15:59 -0500
Date: Sun, 19 Jan 2003 16:24:58 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: "Paul E. Erkkila" <pee@erkkila.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of ide-cdrom writing?
Message-ID: <20030119152458.GA28354@ulima.unil.ch>
References: <20030119130049.GA15941@ulima.unil.ch> <3E2ABD9C.9040903@erkkila.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E2ABD9C.9040903@erkkila.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2003 at 03:00:44PM +0000, Paul E. Erkkila wrote:

> I can confirm it worked this morning with 2.5.58.
> 
> cdrecord --version
> Cdrecord 2.0 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
> 
> uname -a
> Linux nipplehead 2.5.58 #77 Thu Jan 16 02:57:13 GMT 2003 i686 AMD 
> Athlon(TM) XP2000+ AuthenticAMD GNU/Linux
> 
> I do know vcdxrip hasn't worked since 2.5.42 or so.
> 
> This is a 1/2 gentoo, 1/2 my fault box.

Well, lots of people have CD-writer working, as you don't tell which
unit you have, I don't know wheter it's a CD or a DVD writer one???

And are you really not using ide-scsi?

Is there anybody which has success with DVD-writer under 2.5.59 without
ide-scsi?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
