Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbRE0MD3>; Sun, 27 May 2001 08:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261913AbRE0MDU>; Sun, 27 May 2001 08:03:20 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:52744 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S261894AbRE0MDN>; Sun, 27 May 2001 08:03:13 -0400
Date: Sun, 27 May 2001 14:02:49 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem compiling kernel 2.4.5 with gcc 2.96
Message-ID: <20010527140249.F22468@arthur.ubicom.tudelft.nl>
In-Reply-To: <01052713530300.01775@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01052713530300.01775@localhost.localdomain>; from peter.klotz@aon.at on Sun, May 27, 2001 at 01:53:03PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2001 at 01:53:03PM +0200, Peter Klotz wrote:
> When creating the modules (make modules) for my 2.4.5 kernel the compilation 
> aborts with the following error messages. The problem seems to be related 
> with Video for Linux and the Iomega Buz Driver.

buz.c is broken, you need 2.4.5-ac1 for it.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
