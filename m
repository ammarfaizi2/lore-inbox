Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272991AbRI0Nww>; Thu, 27 Sep 2001 09:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273037AbRI0Nwm>; Thu, 27 Sep 2001 09:52:42 -0400
Received: from mpi-informatik.de ([139.19.1.1]:65032 "EHLO mail.mpi-sb.mpg.de")
	by vger.kernel.org with ESMTP id <S272991AbRI0Nwe>;
	Thu, 27 Sep 2001 09:52:34 -0400
Date: Thu, 27 Sep 2001 15:52:57 +0200
From: Peter Schaefer <pesca@mpi-sb.mpg.de>
To: Michael Goetze <mgoetze5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linker errors (drivers/scsi/scsidrv.o) compiling 2.4.10 on SPARC
Message-ID: <20010927155257.A17546@pirx.mpi-sb.mpg.de>
In-Reply-To: <20010927105026.55277.qmail@web14503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010927105026.55277.qmail@web14503.mail.yahoo.com>; from mgoetze5@yahoo.com on Thu, Sep 27, 2001 at 03:50:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 03:50:26AM -0700, Michael Goetze wrote:
> Hi,
> 
> I'm running Debian GNU/Linux woody on my SPARCstation 5 and trying to
> compile Linux 2.4.10. Making all_targets fails  ...


Same error here. 
Another question: is there a reason, why the pppoe option doesn't show up in make menuconfig? 
Is this considered non working? I patched the the Config.in file to show up again, it compiled 
correctly but I could not test it because of the error. 

Bye Peter

