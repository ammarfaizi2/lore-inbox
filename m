Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319543AbSIMHfg>; Fri, 13 Sep 2002 03:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319545AbSIMHfg>; Fri, 13 Sep 2002 03:35:36 -0400
Received: from isis.telemach.net ([213.143.65.10]:17424 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S319543AbSIMHfe>;
	Fri, 13 Sep 2002 03:35:34 -0400
Date: Fri, 13 Sep 2002 09:35:29 +0200
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: linux-kernel@vger.kernel.org
Subject: NTFS errors
Message-Id: <20020913093529.517f6d14.Gregor.Fajdiga@telemach.net>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,

I am using lk 2.4.19 + a NTFS 2.1.0 patch. Once in a while I get
lots of these errors:

Sep 10 09:24:27 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.
Sep 12 09:39:29 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.
Sep 13 09:19:28 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.
Sep 13 09:20:22 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.


Are these errors serious? How can I get rid of them?

Best Regards,

Grega Fajdiga
