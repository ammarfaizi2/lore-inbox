Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261709AbREOXow>; Tue, 15 May 2001 19:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbREOXom>; Tue, 15 May 2001 19:44:42 -0400
Received: from pec-102-189.tnt3.h2.uunet.de ([149.225.102.189]:57360 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S261709AbREOXog>; Tue, 15 May 2001 19:44:36 -0400
Date: Tue, 15 May 2001 23:44:23 +0000
From: Thorsten Kranzkowski <th@Marvin.DL8BCU.ampr.org>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/sch0 interface
Message-ID: <20010515234422.B32162@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@gmx.net
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010515150801.A18842@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010515150801.A18842@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, May 15, 2001 at 03:08:01PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 03:08:01PM -0600, Jeff V. Merkey wrote:
> 
> 
> Is anyone actuaslly using the /dev/sch0 interface for SCSI tape changers
> in Linux?  I noticed that the device definitions are present, but I do not 
> see any driver shipped in the standard base that actually uses it.

http://www.in-berlin.de/User/kraxel/linux.html

works very well here (needs a minor #include to compile correctly, though)

I actually wonder why this isn't in the mainline kernel.

> 
> Thanks
> 
> Jeff
> 

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@gmx.net                        |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
