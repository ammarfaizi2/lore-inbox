Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBLLCy>; Mon, 12 Feb 2001 06:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbRBLLCo>; Mon, 12 Feb 2001 06:02:44 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:27402 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129031AbRBLLCi>; Mon, 12 Feb 2001 06:02:38 -0500
Date: Mon, 12 Feb 2001 11:58:35 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Brian Grossman <brian@SoftHome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysinfo.sharedram not accounted for on i386 ?
Message-ID: <20010212115835.C1691@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010212070503.31764.qmail@lindy.softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010212070503.31764.qmail@lindy.softhome.net>; from brian@SoftHome.net on Mon, Feb 12, 2001 at 12:05:03AM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2001 at 12:05:03AM -0700, Brian Grossman wrote:
> On i386, sysinfo.sharedram is not accounted for, leading /proc/meminfo to
> always report MemShared as 0.  Is this the intended behavior?

Yes.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
