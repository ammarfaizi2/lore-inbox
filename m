Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129976AbRB1AVA>; Tue, 27 Feb 2001 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130004AbRB1AUu>; Tue, 27 Feb 2001 19:20:50 -0500
Received: from n-dialin-4401.addcom.de ([62.246.21.81]:4612 "HELO
	marvin.mahowi.de") by vger.kernel.org with SMTP id <S129976AbRB1AUm>;
	Tue, 27 Feb 2001 19:20:42 -0500
Date: Tue, 27 Feb 2001 15:08:30 +0100
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.4.2-ac5] X (4.0.1) crashes
Message-ID: <20010227150830.A739@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.2-ac5 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Yesterday I've upgraded my 2.4.2 kernel to ac5, because loop-device
seems not to work in plain 2.4.2. But now my X-server crashes.

When I start with startx, X comes up, gnome starts, sawfish starts. Then
the system freezes. Even SysRQ-keys don't work.

I use XFree86 4.0.1 with nvidia-drivers 0.96.

I can't find anything about the crash in the logs, even the output from
X doesn't get written to disk.

Is this a known problem?

I'm going back to vanilla 2.4.2 for now. Is there another way to get
loop to work?

Bye,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or at "http://www.mahowi.de/"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | GPG: 0x88BC3576 * ICQ: 61597169
