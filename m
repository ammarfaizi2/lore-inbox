Return-Path: <linux-kernel-owner+w=401wt.eu-S1753558AbWLPE5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753558AbWLPE5b (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 23:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWLPE5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 23:57:31 -0500
Received: from [203.26.40.81] ([203.26.40.81]:39855 "EHLO boo.knobbits.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753558AbWLPE5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 23:57:31 -0500
X-Greylist: delayed 1625 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 23:57:30 EST
Message-ID: <4583765F.9050500@knobbits.org>
Date: Sat, 16 Dec 2006 15:30:23 +1100
From: "Michael (Micksa) Slade" <micksa@knobbits.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Inspiron 6000 power problem saga - other people's experiences?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regarding:

http://bugzilla.kernel.org/show_bug.cgi?id=7393

No closer to a solution yet.  I'm worried about this problem because the 
laptop is getting hotter than it's designed for and it is likely 
shortening its life.

To aid in tracking it down, I could use reports of this problem 
happening, or not happening, with other inspiron 6000.  If anyone out 
there has this laptop (or, hell, any in the 6000 series), could you 
please send:

- actual laptop model
- BIOS version
- kernel version, (or distro/package version if you're using a packaged 
kernel)
- output of "lspci -vv"
- output of "cat /proc/acpi/battery/BAT0/state", when it's been idle for 
about 10 seconds (ie no CD in drive, using less than 1% CPU according to 
top(1) or similar, but display is on, hard disk not important), and with 
charger disconnected

Any help is greatly appreciated.

Mick.

