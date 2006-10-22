Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWJVVPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWJVVPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 17:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWJVVPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 17:15:09 -0400
Received: from main.gmane.org ([80.91.229.2]:59018 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750751AbWJVVPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 17:15:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Anders Larsen <al@alarsen.net>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Sun, 22 Oct 2006 23:09:32 +0200
Organization: systems engineer Anders Larsen
Message-ID: <pan.2006.10.22.21.09.32.177539@alarsen.net>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org> <20061021002251.GO20017@pasky.or.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54ac104d.dip0.t-ipconnect.de
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Oct 2006 02:22:51 +0200, Petr Baudis wrote:

>> That said, "LESS=FRS" doesn't really help that much. It still clears the 
>> screen. Using "LESS=FRSX" fixes that, but the alternate display sequence 
>> is actually nice _if_ the pager is used.
> 
> Hmm, what terminal emulator do you use? The reasonable ones should
> restore the original screen.

And indeed they do.
The problem is, when the original screen is restored, the diff output that
was paged through less -FRS goes poof as well.

Cheers
 Anders



