Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAHUKX>; Mon, 8 Jan 2001 15:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAHUKN>; Mon, 8 Jan 2001 15:10:13 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:29703 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129324AbRAHUKC>; Mon, 8 Jan 2001 15:10:02 -0500
Date: Mon, 8 Jan 2001 21:09:20 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Blizbor <tb670725@ima.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.2 kernels (mysterious hangs after freeing unused memory)
Message-ID: <20010108210920.U3472@arthur.ubicom.tudelft.nl>
In-Reply-To: <5.0.0.25.0.20010107190604.00a44400@195.117.13.2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.0.0.25.0.20010107190604.00a44400@195.117.13.2>; from tb670725@ima.pl on Sun, Jan 07, 2001 at 07:21:08PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 07:21:08PM +0100, Blizbor wrote:
> I have found something weird in kernel 2.2.17.
> After installation on the Pentium PRO equipped machine,
> I have moved hard disk to another one, but equipped
> with AMD-K5 and after encountering problems I moved again
> this disk to machine equipped with Intel Pentium MMX.
> 
> On all machines except Pentium PRO boot process was stopping
> after freeing unused kernel memory.

A kernel compiled and optimised for a PPro does not neccesarily run on
an AMD K5 or a Pentium MMX.


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
