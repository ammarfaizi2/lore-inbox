Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319490AbSILV0b>; Thu, 12 Sep 2002 17:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319494AbSILV0b>; Thu, 12 Sep 2002 17:26:31 -0400
Received: from ulima.unil.ch ([130.223.144.143]:45193 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S319490AbSILV0a>;
	Thu, 12 Sep 2002 17:26:30 -0400
Date: Thu, 12 Sep 2002 23:31:21 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: FD Cami <stilgar2k@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 don't find my root (aic7xxx or ???)
Message-ID: <20020912213121.GB14671@ulima.unil.ch>
References: <20020912090755.GA5890@ulima.unil.ch> <3D805DC6.8000804@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D805DC6.8000804@wanadoo.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 11:26:30AM +0200, FD Cami wrote:

> Maybe you didn't compile the right filesystem for your / in your
> kernel. Check supported Filesystems in your kernel config.

I have just checked, and yes, it was compiled (at least reiserfs is
shown as in by menuconfig...).

Any other idea?

I also use devfs (I see just another post here about same problem, but
it wasn't explicit which SCSI he had...).

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
