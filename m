Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266468AbRGFMEb>; Fri, 6 Jul 2001 08:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266465AbRGFMEV>; Fri, 6 Jul 2001 08:04:21 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:65287 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S266457AbRGFMEI>; Fri, 6 Jul 2001 08:04:08 -0400
Date: Fri, 6 Jul 2001 14:03:27 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Naveen Kumar Pagidimarri <naveen.pagidimarri@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: access to sysinfo structure
Message-ID: <20010706140327.W30999@arthur.ubicom.tudelft.nl>
In-Reply-To: <GG1VH700.L3W@vindhya.mail.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <GG1VH700.L3W@vindhya.mail.wipro.com>; from naveen.pagidimarri@wipro.com on Fri, Jul 06, 2001 at 05:18:43PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 05:18:43PM +0530, Naveen Kumar Pagidimarri wrote:
> 	 Is it possible to access sysinfo structure(which is in 
> 
> kernel.h) .This is related to system detailes(like Ram and other info)
> 
> Actually this is updarted in init.c.Is it possible to access this
> 
> information from userspace.

cat /proc/loadavg
cat /proc/meminfo
cat /proc/uptime


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
