Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUAOWFQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUAOWFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:05:16 -0500
Received: from rrcs-central-24-123-144-118.biz.rr.com ([24.123.144.118]:10810
	"EHLO zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id S263625AbUAOWD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:03:26 -0500
Subject: 2.6.1-mm3 minor issues
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1074204199.5494.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 15 Jan 2004 17:03:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my continuing effort to get my Dell Latitude D800 running perfectly
with 2.6.x I recently upgraded to 2.6.1-mm3.  I'll have to admit it's
getting very close, but I still have the following minor issues I hope
someone can help me with.

1.  When using an external USB mouse (a basic Microsoft Optical Wheel
Mouse) everything works fine unless I move the mouse very fast, then the
pointer seems to stall and stutter randomly in the same location. 
Moving the mouse very quickly back and forth across my mouse pad will
make the mouse jump all over the screen randomly.  It doesn't have this
behaviour under 2.4.  My ALPS touchpad (using the Synaptics driver with
the ALPS patch) works flawlessly.

2.  I cannot put my system to standby and them properly resume it. 
Under 2.4.x with the recent ACPI patches I can put the system into S1
state and it will resume.  With 2.6.x the system does seem to enter S1
state but it hangs on resume with no informational messages.  Suspend
state (S3 and S4) don't work on either 2.4 or 2.6 but I think that's
"normal" so this isn't a significant concern, but the S1 state was nice
when I just needed to walk from one building to another.

Any help or suggestions would be appreciated.

Later,
Tom




