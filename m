Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288414AbSAQMca>; Thu, 17 Jan 2002 07:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288637AbSAQMcT>; Thu, 17 Jan 2002 07:32:19 -0500
Received: from duteinh.et.tudelft.nl ([130.161.42.1]:54542 "EHLO
	duteinh.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S288414AbSAQMcI>; Thu, 17 Jan 2002 07:32:08 -0500
Date: Thu, 17 Jan 2002 13:31:42 +0100
From: Erik Mouw <J.A.K.Mouw@its.tudelft.nl>
To: Johan Adolfsson <johan.adolfsson@axis.com>
Cc: quinlan@transmeta.com, Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs updates for 2.4.17
Message-ID: <20020117123142.GB28788@arthur.ubicom.tudelft.nl>
In-Reply-To: <15430.14470.999605.380374@sodium.transmeta.com> <18e701c19f40$88d8fdd0$0a070d0a@axis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e701c19f40$88d8fdd0$0a070d0a@axis.se>
User-Agent: Mutt/1.3.25i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 11:20:06AM +0100, Johan Adolfsson wrote:
> Daniel Quinlan wrote:
> > Assuming it's okay with Linus and Marcelo, I'll remove scripts/cramfs
> > in the next version of the patch (which should be fine for 2.5 too).
> 
> Why move it?

Because leaving it in the kernel tree would be an invitation to move
mke2fs, mkreiserfs, mkxfsfs, etc. into the kernel source tree as well.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Faculty
of Information Technology and Systems, Delft University of Technology,
PO BOX 5031, 2600 GA Delft, The Netherlands  Phone: +31-15-2783635
Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
