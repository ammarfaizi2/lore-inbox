Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUBDSa7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUBDSa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:30:59 -0500
Received: from main.gmane.org ([80.91.224.249]:21690 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263537AbUBDSaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:30:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Stefan 'Steve' Tell" <stv-news@crashmail.de>
Subject: Kernel 2.6.2 and sensors
Date: Wed, 04 Feb 2004 19:20:29 +0100
Organization: The Third Place
Message-ID: <87ad3yln9u.fsf@zeus.crashmail.de>
Reply-To: stefan.tell@crashmail.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e3373e.dip.t-dialin.net
X-Face: .KSo,m`RE@]&5>cJ8vw<`1x?R(?,Q]b@qeq;P\.fK\}i>U^v9f;/~+rKfXKOJ$jD@Fo<D@iT~$f6'T5>y7MtnIpnk+6]/](%q@*/|+M<4.q@SO3+)u
X-PGP-Key: 0x6A179CE0
X-PGP-Fingerprint: A59C 9791 7E26 785F 8302  B2CF EA0E 6D6E 6A17 9CE0
X-Kernel-Version: Linux pandora 2.6.2 #3 SMP Wed Feb 4 18:33:10 CET 2004
 i686 AMD Athlon(tm) Processor AuthenticAMD GNU/Linux
X-Gentoo-Release: Gentoo Base System version 1.4.3.10
User-Agent: Gnus/5.1004 (Gnus v5.10.4) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:0kyXolq19VQZLfimYEimwbWQxd8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

damn,

and here is the complete mail :)

> ----
Hi Folks,

I have some problems with my sensors.

In kernel 2.6.1 i received temperatures like 69,5°C CPU and 41°C
mainboard. Since 2.6.2 I received 418,5°C CPU and 347,0°C
mainboard. This error occured in 2.6.2rc3, too.

My hardware an Asus A7V133 mainboard, I used the following modules:

,----
| i2c-dev
| i2c-viapro  
| eeprom  
| via686a
| w83781d
`----

Do you need any other informations?

Any hints? Bug?

-- 
Farewell to home; my heart is an endless hole
Dancing alone; no one who protects my soul
			   - The Jinxs -, "M.I. Young", 1995

