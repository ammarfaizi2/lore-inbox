Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbRE3Vku>; Wed, 30 May 2001 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262762AbRE3Vkj>; Wed, 30 May 2001 17:40:39 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:41992 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S262702AbRE3Vkd>; Wed, 30 May 2001 17:40:33 -0400
Date: Wed, 30 May 2001 23:40:18 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: hiren_mehta@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Procfs Guide
Message-ID: <20010530234018.B3316@arthur.ubicom.tudelft.nl>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880A88@xsj02.sjs.agilent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880A88@xsj02.sjs.agilent.com>; from hiren_mehta@agilent.com on Wed, May 30, 2001 at 03:10:32PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 03:10:32PM -0600, hiren_mehta@agilent.com wrote:
> So where can find the whole docbook ?  I could not find under
> linux/Documentation directory.

That's correct, I only submitted it for inclusion into the kernel, so
it's not yet there. Just patch your kernel source with my patch, run
"make psdocs" and you'll have it in your kernel tree as well.

However, because we got a similar procfs question on the kernelnewbies
list, I already put the html and pdf versions online on the
kernelnewbies documentation pages:

  http://www.kernelnewbies.org/documents/kdoc/procfs-guide/lkprocfsguide.html


Erik

PS: Was it really necessary to quote my complete message *including*
    the patch? Next time quote properly before you post.

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
