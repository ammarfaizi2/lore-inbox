Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbRFYTTH>; Mon, 25 Jun 2001 15:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbRFYTS5>; Mon, 25 Jun 2001 15:18:57 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:16653 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261425AbRFYTSl>; Mon, 25 Jun 2001 15:18:41 -0400
Date: Mon, 25 Jun 2001 21:08:24 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MemShared == 0 ?
Message-ID: <20010625210824.Y641@arthur.ubicom.tudelft.nl>
In-Reply-To: <lx1yo86erg.fsf@pixie.isr.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <lx1yo86erg.fsf@pixie.isr.ist.utl.pt>; from yoda@isr.ist.utl.pt on Mon, Jun 25, 2001 at 11:21:55AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 11:21:55AM +0100, Rodrigo Ventura wrote:
> /proc> cat version meminfo
> Linux version 2.4.6-pre3 (yoda@damasio) (gcc version 2.95.2 19991024 (release)) #3 Mon Jun 18 19:00:11 WEST 2001
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  261779456 256925696  4853760        0 134025216 82280448
> Swap: 271425536 10993664 260431872     ^^^^
> MemTotal:       255644 kB                  \
> MemFree:          4740 kB                   \
> MemShared:           0 kB  <<<<<<<<<< **** What's the meaning of this? *****

Check the lkml FAQ: http://www.tux.org/lkml/#s14-3


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
