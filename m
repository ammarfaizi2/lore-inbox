Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292389AbSB0Nhy>; Wed, 27 Feb 2002 08:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292403AbSB0Nhp>; Wed, 27 Feb 2002 08:37:45 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:19728 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S292389AbSB0Nhd>; Wed, 27 Feb 2002 08:37:33 -0500
Date: Wed, 27 Feb 2002 14:35:44 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Suporte RedeBonja <suporte@cbj.g12.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel oops
Message-ID: <20020227133544.GE3316@arthur.ubicom.tudelft.nl>
In-Reply-To: <003301c1bef3$156119a0$5600a8c0@c136suporte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003301c1bef3$156119a0$5600a8c0@c136suporte>
User-Agent: Mutt/1.3.27i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 03:26:15PM -0300, Suporte RedeBonja wrote:
> we are having problems with the kernel (oops). My box is a mail server only
> and the problem occurs a thousand times a day . I realize a wierd message on
> the boot process: /lib/modules/2.2.16/net/bsd_comp.o _> unresolved symbols,
> the same message for: /lib/modules/2.2.16/misc/zft_compressor.o,
>  /lib/modules/2.2.16/misc/rio.o,
> /lib/modules/2.2.16/misc/dss1_divert.o.
> 
> here is my configuration:
> 
> Red Hat 6.1 (Cartman)
> kernel : 2.2.16

Upgrade the system to a newer kernel and tools (look at ksymoops
complaining being obsolete) and try to recreate the problem.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
