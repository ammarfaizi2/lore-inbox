Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132629AbRDWKVj>; Mon, 23 Apr 2001 06:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132659AbRDWKVa>; Mon, 23 Apr 2001 06:21:30 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:3845 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132629AbRDWKVR>; Mon, 23 Apr 2001 06:21:17 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200104231021.f3NAL7P22306@xyzzy.clara.co.uk>
Subject: New driver for FarSite synchronous cards
To: linux-kernel@vger.kernel.org
Date: Mon, 23 Apr 2001 11:21:07 +0100 (BST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just completed the first draft of a new device driver for the FarSite
Communications, FarSync T2P and T4P cards.  These cards are intelligent
synchronous serial cards supporting 2 or 4 ports running at up to 8Mbps with
X.21, V.35 or V.24 signalling.

This mail is basically a call for testers and reviewers, and a plea to find
the overall maintainer for WAN card drivers.

In house testing and review of the drivers is underway and until that is
complete I can't put the sources on the company web site.  However I have been
given permission to place the sources on my home site so that I can hopefully
get some early testing and reviews from the community.  So please pull them
apart guys.

The sources are available at http://www.xyzzy.clara.co.uk/farsync either as a
complete package with firmware, support utilities, driver etc for 2.2.x (from
2.2.15) and 2.4.x systems, or as a driver only patch for 2.4.3ac12.  The latter
I'm keen to get adopted as part of the standard kernel source (once reviewed
of course) and hence the need to find the maintainer for that part of the
kernel.  If it's you please get in contact, meantime I'm going to assume it's
the much overworked Alan Cox.


Sources and patches at:
    http://www.xyzzy.clara.co.uk/farsync/

More info on cards and other drivers at:
    http://www.farsite.co.uk/

-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
