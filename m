Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbTGOUb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269646AbTGOUb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:31:59 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:32409 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id S269645AbTGOUb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:31:58 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
Organization: vanheusdendotcom
To: linux-kernel@vger.kernel.org
Subject: v2.6.0-test1 - no keyboard/mouse
Date: Tue, 15 Jul 2003 22:46:57 +0200
User-Agent: KMail/1.5.2
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307152246.57389.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ehrm, hello? Has this list became silent suddenly?
Anyway: I just tried 2.6.0-test1 on my celeron. Boots up flawlessly. Rather 
quick and all. X boots up, all fine.
Only one minor problem: the keyboard and the mouse do not work.
I *have* included input-core, etc.:
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=y
Anyone got a suggestion?
You'll find the complete .config at vanheusden.com/config260 (not
attached to reduce unneccessary traffic).


Folkert van Heusden

p.s. please CC me: I'm not sure if I'm still on this list or not

+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+---------------------------------------------------= www.vanheusden.com =-+

