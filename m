Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129823AbQLOPJO>; Fri, 15 Dec 2000 10:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132229AbQLOPJE>; Fri, 15 Dec 2000 10:09:04 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:11717 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129823AbQLOPIx>; Fri, 15 Dec 2000 10:08:53 -0500
Date: Fri, 15 Dec 2000 16:37:47 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Tommy Wu <tommy@teatime.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug: kernel timer added twice ad 000000000110052c.
Message-ID: <20001215163747.F829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A3A0D9A.426A2FB0@teatime.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A3A0D9A.426A2FB0@teatime.com.tw>; from tommy@teatime.com.tw on Fri, Dec 15, 2000 at 08:24:58PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 08:24:58PM +0800, Tommy Wu wrote:
>   I got the message as subject when I load the ip_conntrack/iptable_nat modules
>   for kernel 2.4.0-test9 to test12. All have the same problem.

Don't do that.

Recompile the modules _ALWAYS_ along with the kernel you compile
and use.

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
