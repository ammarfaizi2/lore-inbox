Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135256AbRDWOmL>; Mon, 23 Apr 2001 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135250AbRDWOmC>; Mon, 23 Apr 2001 10:42:02 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:54545 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135246AbRDWOlr>; Mon, 23 Apr 2001 10:41:47 -0400
Date: Mon, 23 Apr 2001 16:40:13 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Bram Smout <bram@ba.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SGI Visual Workstation Support
Message-ID: <20010423164013.K2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <200104231415.f3NEFo917210@ev6.be.wanadoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104231415.f3NEFo917210@ev6.be.wanadoo.com>; from bram@ba.be on Mon, Apr 23, 2001 at 10:12:14PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 10:12:14PM +0200, Bram Smout wrote:
> If I try to compile a 2.4.x (0-3) kernel for my SGI 540 Workstation and I
> enable SGI Virtual Workstation support (under general setup) the compilation
> stops with the error "kernel.o: In function 'enable_irq' etc...".
> 
> Previous kernels, such as 2.2.19 compile without any problem (same options).
> Anyone a idea of what's wrong ?

Bit rot. Nobody actually has a SGI VW, so it's currently not
maintained.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
