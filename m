Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbTAIAzz>; Wed, 8 Jan 2003 19:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267730AbTAIAzz>; Wed, 8 Jan 2003 19:55:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:37576 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267726AbTAIAzy>;
	Wed, 8 Jan 2003 19:55:54 -0500
Date: Wed, 8 Jan 2003 17:01:00 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "studio3arc.com Admin" <admin@studio3arc.com>
cc: <henrique.gobbi@cyclades.com>, <linux-kernel@vger.kernel.org>
Subject: RE: modutils x 2.5.54
In-Reply-To: <001701c2b77a$18336630$6601a8c0@s3ac>
Message-ID: <Pine.LNX.4.33L2.0301081659230.6873-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, studio3arc.com Admin wrote:

|
| > modprobe --version
| > gives me 0.9.5.
| >
| > lsmod and insmod don't support --version.
| >
|
| I get the following 2.4.12 !?!? Now I'm very confused
|
|
| s3a-www:/usr/src/linux-2.4.18.SuSE # modprobe --version
| modprobe version 2.4.12
| modprobe: Nothing to load ???
| Specify at least a module or a wildcard like \*
| s3a-www:/usr/src/linux-2.4.18.SuSE #

Did you install the new mod-utils?  ('make install' as root)
and how did you tell the new mod-utils that you want to use them?
Sounds like you need to read the README and INSTALL files...

-- 
~Randy

