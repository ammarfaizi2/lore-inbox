Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSKRVmW>; Mon, 18 Nov 2002 16:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSKRVmW>; Mon, 18 Nov 2002 16:42:22 -0500
Received: from ulima.unil.ch ([130.223.144.143]:50585 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264903AbSKRVmV>;
	Mon, 18 Nov 2002 16:42:21 -0500
Date: Mon, 18 Nov 2002 22:49:22 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.48 and SCSI ? (devfs problem!!!)
Message-ID: <20021118214922.GA9613@ulima.unil.ch>
References: <20021118203605.GC8357@ulima.unil.ch> <Pine.LNX.4.44.0211182329020.736-100000@kai.makisara.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0211182329020.736-100000@kai.makisara.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:33:58PM +0200, Kai Makisara wrote:
> On Mon, 18 Nov 2002, Gregoire Favre wrote:
> 
> > Hello,
> >
> > I have applied the patch sent today, but the kernel don't find my root
> > (aic7xxx), what I got is:
> >
> I had the same problem with sym53c8xxx_2 when devfs was configured into
> the kernel (but not mounted). Then I made a kernel with devfs disabled and
> now this boots (and seems to work).

Hello,

well, I "need" devfs and it is mounted... I really don't want to create
all the devices I use... At least now I know where does the prolem come
from ;-)

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
