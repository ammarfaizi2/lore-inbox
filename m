Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbQLLOES>; Tue, 12 Dec 2000 09:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131739AbQLLOEI>; Tue, 12 Dec 2000 09:04:08 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:9230 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129361AbQLLODw>; Tue, 12 Dec 2000 09:03:52 -0500
Date: Tue, 12 Dec 2000 14:32:49 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: jordi <jpallares@alumnes.udl.es>
Cc: llistakernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel error
Message-ID: <20001212143249.J1851@arthur.ubicom.tudelft.nl>
In-Reply-To: <3A3611BC.DF3A6D58@alumnes.udl.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3611BC.DF3A6D58@alumnes.udl.es>; from jpallares@alumnes.udl.es on Tue, Dec 12, 2000 at 12:53:33PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2000 at 12:53:33PM +0100, jordi wrote:
> I try to upgrade my 2.2.5-17 kernel to 2.4-test11 but when I put make
> modules_install  and it is in pcmacia module the make crash because it
> put -F option.
> 
> when I see the syntax not appear this option and I don't have a answer?
> 
> You can help me?

Yes, upgrade to the latest modutils. See the file Documentation/Changes
in the kernel source tree.


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
