Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267680AbTA1UZ1>; Tue, 28 Jan 2003 15:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267691AbTA1UZ1>; Tue, 28 Jan 2003 15:25:27 -0500
Received: from imap.gmx.net ([213.165.65.60]:8068 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267680AbTA1UZ0>;
	Tue, 28 Jan 2003 15:25:26 -0500
Date: Tue, 28 Jan 2003 21:34:35 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 and scp
Message-Id: <20030128213435.0597df5e.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.5claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

When I copy larger files with scp over the network then suddenly the keyboard hangs. This never happend with any kernel < 2.4.20. Interestingly is that i can't trigger it with a "normal" ssh session...

Also intersting is that my mouse is still working and I can shutdown xwindow with the mouse. But then the only keys which are working are alt-sysrq-*.

When the keyboard hangs it's also impossibel to connect to the machine with ssh over the network..

Is it already known?

Thank you

Marc
