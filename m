Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSAQBRG>; Wed, 16 Jan 2002 20:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288010AbSAQBQ5>; Wed, 16 Jan 2002 20:16:57 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:7948 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S288012AbSAQBQo>; Wed, 16 Jan 2002 20:16:44 -0500
Date: Thu, 17 Jan 2002 02:15:20 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: J Sloan <jjs@lexus.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Rik spreading bullshit about VM
Message-ID: <20020117011520.GM10175@arthur.ubicom.tudelft.nl>
In-Reply-To: <20020116200459.E835@athlon.random> <20020117000758.GL10175@arthur.ubicom.tudelft.nl> <3C461A09.8060900@lexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C461A09.8060900@lexus.com>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 04:25:45PM -0800, J Sloan wrote:
> Nice try, but do the test again with 2.4.18-pre2-aa2 -
> 
> 2.4.17 doesn't neccesarily have all andrea's fixes.

Nice try, but 2.4.17-rmap-11a doesn't have all Rik's fixes either
(rmap-11b is available, but I don't feel like running a new kernel
every few days).

I've been running a couple of 2.4.17-pre kernels on my laptop (which is
my primary machine), but each time they made me switch back to good old
2.4.13-ac5 simply because its VM (read: Rik's VM) was much smoother.

It's not that I think Andrea's VM is bad, it's just that a VM should be
tuned for the common cases, not for the power users that want to
squeeze every last drop out of it. It's fine with me if somebody wants
to design a VM for the niche XYZ, but do that as a separate patch and
don't clutter up the mainline kernel with it.


Erik
[sleep(7*3600);]

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
