Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVBBNvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVBBNvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 08:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbVBBNvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 08:51:04 -0500
Received: from main.gmane.org ([80.91.229.2]:9966 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262364AbVBBNur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 08:50:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Subject: cdrtools 2.01 not working in 2.6.10
Date: Wed, 02 Feb 2005 13:49:58 +0000
Message-ID: <m3651bdqbd.fsf@pixie.isrnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gtisr.ist.utl.pt
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:VT79ixagwm0BtmFmiGkyE8VngJk=
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I can't use cdrtools 2.01 with kernel 2.6.10 (i386, P4). Once the "0
of xxx MB written" message appears, the CD-writer spins down, the HD
led lits, and the system nearly hangs (many processes in D(isk)
state). After a minute or two, timeout messages on hda (main HD)
appear in dmesg, followed by hdc (CD-writer, plextor) timeout
messages.

Is this a known issue of 2.6.10? I'm not giving more details because I
believe I'm not the only one with this problem.

However, all works fine with 2.6.9.

If this is an unknown issue, I could give more details (logs, config,
etc.). Otherwise, will this be solved by 2.6.11?

Cheers,

Rodrigo Ventura

PS: please CC replies to me (yoda AT isr DOT ist DOT utl DOT pt).

-- 

*** Rodrigo Martins de Matos Ventura <yoda@isr.ist.utl.pt>
***  Web page: http://www.isr.ist.utl.pt/~yoda
***   Teaching Assistant and PhD Student at ISR:
***    Instituto de Sistemas e Robotica, Polo de Lisboa
***     Instituto Superior Tecnico, Lisboa, PORTUGAL
*** PGP fingerprint = 0119 AD13 9EEE 264A 3F10  31D3 89B3 C6C4 60C6 4585

