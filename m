Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281635AbRKPXCD>; Fri, 16 Nov 2001 18:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281092AbRKPXBx>; Fri, 16 Nov 2001 18:01:53 -0500
Received: from flounder.jimking.net ([209.205.176.18]:35336 "EHLO
	flounder.jimking.net") by vger.kernel.org with ESMTP
	id <S281639AbRKPXBm>; Fri, 16 Nov 2001 18:01:42 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Totally Stumped
In-Reply-To: <E164rg7-0005Mz-00@the-village.bc.nu>
From: Tony Reed <Tony@TRLJC.COM>
Encrypted: : PGP
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i586-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011116230113.14A6215B4A@kubrick.trljc.com>
Date: Fri, 16 Nov 2001 18:01:13 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001 22:41:43 +0000 (GMT)
  Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>> [1.0] Won't compile 8139too
>
:Please dont use gcc 3.x to compile kernels
>
>>     (nil)) 8139too.c:2432: Internal compiler error in
>>     reload_cse_simplify_operands, at reload1.c:8355 Please submit a full
>>     bug report, with preprocessed source if appropriate.  See
>>     <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
>
:But do report the data on the compiler failure to the URL above


Thanks for the reply Alan.  I had a hunch about that.  I'm not the
greatest programmer in the universe, but I've noticed that there's
some stuff you just can't build with 3.0.x.  I built and and
installed 2.95.3, and the kernel is ticking over nicely in the bg even
as we speak. Fortunately, 3.0.1 bootstrapped 2.95.3 for me ...

Thanks again, and for all the good work too.

-- 
   Tony Reed 
<Tony@TRLJC.COM>
