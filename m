Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSKSHoZ>; Tue, 19 Nov 2002 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSKSHoZ>; Tue, 19 Nov 2002 02:44:25 -0500
Received: from ulima.unil.ch ([130.223.144.143]:58521 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S263362AbSKSHoY>;
	Tue, 19 Nov 2002 02:44:24 -0500
Date: Tue, 19 Nov 2002 08:51:22 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 and SCSI ? (devfs problem!!!)
Message-ID: <20021119075122.GA3858@ulima.unil.ch>
References: <20021118203605.GC8357@ulima.unil.ch> <Pine.LNX.4.44.0211182329020.736-100000@kai.makisara.local> <20021118214922.GA9613@ulima.unil.ch> <20021118211730.A24422@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021118211730.A24422@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 09:17:30PM -0800, Patrick Mansfield wrote:

> Here's a patch you can try out, I already posted this to linux-scsi
> as a fix for /proc/scsi not showing up, I'll make sure James or
> someone pushes it to Linus' tree. I don't use devfs.
> 
> This is against linus bk but should apply fine against 2.5.48.

I'll try it tonight, thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
