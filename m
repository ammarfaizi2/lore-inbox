Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132864AbRDDRcr>; Wed, 4 Apr 2001 13:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132865AbRDDRch>; Wed, 4 Apr 2001 13:32:37 -0400
Received: from u-28-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.28]:60664
	"EHLO dea.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S132864AbRDDRcV>; Wed, 4 Apr 2001 13:32:21 -0400
Date: Wed, 4 Apr 2001 18:36:50 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Lehrer <mark@knm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "linux" terminal type
Message-ID: <20010404183650.B4214@bacchus.dhis.org>
In-Reply-To: <200104040307.VAA03580@home.knm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104040307.VAA03580@home.knm.org>; from mark@knm.org on Tue, Apr 03, 2001 at 09:07:55PM -0600
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 09:07:55PM -0600, Mark Lehrer wrote:
> Date: 	Tue, 3 Apr 2001 21:07:55 -0600
> From: Mark Lehrer <mark@knm.org>
> To: linux-kernel@vger.kernel.org
> Subject: "linux" terminal type
> 
> 
> Is there any documentation on ths linux console terminal type?  If
> so, where?

Maybe cryptic but the most complete documentation of the linux terminal
and it's relatives are probably /etc/termcap and the ncurses terminfo
database.  Aside of the code itself.

  Ralf
