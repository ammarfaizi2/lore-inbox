Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261737AbREPAn2>; Tue, 15 May 2001 20:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbREPAnJ>; Tue, 15 May 2001 20:43:09 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:13323 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S261739AbREPAnI>; Tue, 15 May 2001 20:43:08 -0400
Date: Tue, 15 May 2001 18:35:51 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/sch0 interface
Message-ID: <20010515183551.A20219@vger.timpanogas.org>
In-Reply-To: <20010515150801.A18842@vger.timpanogas.org> <20010515234422.B32162@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010515234422.B32162@Marvin.DL8BCU.ampr.org>; from th@Marvin.DL8BCU.ampr.org on Tue, May 15, 2001 at 11:44:23PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 11:44:23PM +0000, Thorsten Kranzkowski wrote:
> On Tue, May 15, 2001 at 03:08:01PM -0600, Jeff V. Merkey wrote:
> > 
> > 
> > Is anyone actuaslly using the /dev/sch0 interface for SCSI tape changers
> > in Linux?  I noticed that the device definitions are present, but I do not 
> > see any driver shipped in the standard base that actually uses it.
> 
> http://www.in-berlin.de/User/kraxel/linux.html
> 
> works very well here (needs a minor #include to compile correctly, though)
> 
> I actually wonder why this isn't in the mainline kernel.
> 
> > 
> > Thanks
> > 
> > Jeff
> > 
> 
> Thorsten

Thanks.

Jeff

> 
> -- 
> | Thorsten Kranzkowski        Internet: dl8bcu@gmx.net                        |
> | Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
> | Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
