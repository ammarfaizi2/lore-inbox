Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271639AbRHUMkJ>; Tue, 21 Aug 2001 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271645AbRHUMkA>; Tue, 21 Aug 2001 08:40:00 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:43023 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S271639AbRHUMjq>; Tue, 21 Aug 2001 08:39:46 -0400
Date: Tue, 21 Aug 2001 14:39:54 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Frank Neuber <neuber@convergence.de>
Cc: Milind <dmilind@india.hp.com>, linux-kernel@vger.kernel.org,
        blore-linux@yahoogroups.com
Subject: Re: Info about /dev/kmem required
Message-ID: <20010821143954.D2673@arthur.ubicom.tudelft.nl>
In-Reply-To: <3B7D232B.FEA189AD@india.hp.com> <20010817175739.I19385@arthur.ubicom.tudelft.nl> <20010820202108.A7121@jupiter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010820202108.A7121@jupiter>; from neuber@convergence.de on Mon, Aug 20, 2001 at 08:21:08PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 08:21:08PM +0200, Frank Neuber wrote:
> I think You can use /dev/kmem as an corefile for gdb. So it is
> possible to debug the linux kernel (of course read only :-)).

No, that's what /proc/kcore is for.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
