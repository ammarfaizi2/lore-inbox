Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRDAHgk>; Sun, 1 Apr 2001 03:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132039AbRDAHga>; Sun, 1 Apr 2001 03:36:30 -0400
Received: from tamago.synopsys.com ([204.176.20.21]:46978 "EHLO
	tamago.synopsys.com") by vger.kernel.org with ESMTP
	id <S132038AbRDAHgQ>; Sun, 1 Apr 2001 03:36:16 -0400
Message-ID: <3AC6DA1E.3332962D@Synopsys.COM>
Date: Sun, 01 Apr 2001 09:34:54 +0200
From: Harald Dunkel <harri@synopsys.COM>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA 82C686 Audio Codec: Clicks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Has anybody an idea how to get rid of the annoying clicks of the
VIA 82C686 audio codec? Using xmms (just as an example) I get a 
click with each new track, when I move and release the track slider, 
etc.

Even this

	echo -n "" >/dev/dsp

produces a click.


Regards

Harri
