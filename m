Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132301AbRDWVol>; Mon, 23 Apr 2001 17:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132316AbRDWVob>; Mon, 23 Apr 2001 17:44:31 -0400
Received: from ns1.et.tudelft.nl ([130.161.33.17]:60936 "EHLO
	ns1.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S132313AbRDWVoY>; Mon, 23 Apr 2001 17:44:24 -0400
Date: Mon, 23 Apr 2001 23:44:01 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: axel <axel@rayfun.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compile error 2.4.4pre6: inconsistent operand constraints in an `asm'
Message-ID: <20010423234401.Q2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.21.0104232306020.4230-100000@neon.rayfun.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104232306020.4230-100000@neon.rayfun.org>; from axel@rayfun.org on Mon, Apr 23, 2001 at 11:11:14PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 11:11:14PM +0200, axel wrote:
> after having had trouble with compilation due to old gcc version, i have
> updated to gcc 3.0 and received the following error:

Although bug reports about a kernel compiled with gcc-3.0 are welcome,
this is still not the recommended compiler. The recommended compiler is
gcc-2.91.66 (aka egcs-1.1.2), but for most people gcc-2.95.2 works as
well.


Erik
 
-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
