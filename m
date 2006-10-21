Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWJUAWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWJUAWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992747AbWJUAWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:22:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58840 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030355AbWJUAWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:22:53 -0400
Date: Sat, 21 Oct 2006 02:22:51 +0200
From: Petr Baudis <pasky@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.4.3
Message-ID: <20061021002251.GO20017@pasky.or.cz>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That said, "LESS=FRS" doesn't really help that much. It still clears the 
> screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
> is actually nice _if_ the pager is used.

Hmm, what terminal emulator do you use? The reasonable ones should
restore the original screen. At least xterm does, and I *think*
gnome-terminal does too (although I'm too lazy to boot up my notebook
and confirm).

(I personally consider alternate screen an abomination. It would be so
nice if the terminal emulators would just make it optional.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
