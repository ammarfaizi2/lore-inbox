Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAEEv1>; Thu, 4 Jan 2001 23:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbRAEEvH>; Thu, 4 Jan 2001 23:51:07 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:63245
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129415AbRAEEvF>; Thu, 4 Jan 2001 23:51:05 -0500
Date: Fri, 5 Jan 2001 17:51:01 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Frédéric L . W . Meunier 
	<0@pervalidus.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig: where's USB Mass Storage?
Message-ID: <20010105175101.A32406@metastasis.f00f.org>
In-Reply-To: <20010105024211.B225@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010105024211.B225@pervalidus>; from 0@pervalidus.net on Fri, Jan 05, 2001 at 02:42:11AM -0200
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 02:42:11AM -0200, Frédéric L . W . Meunier wrote:

    Is this just me? Configuring 2.4.0 with make menuconfig with
    CONFIG_EXPERIMENTAL=y I get no prompt for USB Mass Storage, but
    the .config is saved with # CONFIG_USB_STORAGE is not set

Enable SCSI and scsi disks (modular is fine).


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
