Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbTCUAd1>; Thu, 20 Mar 2003 19:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263376AbTCUAd1>; Thu, 20 Mar 2003 19:33:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:17102 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263375AbTCUAdZ>; Thu, 20 Mar 2003 19:33:25 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [Bonding-devel] [patch] (2/8) Add 802.3ad support to bonding (released
 to bonding on sourceforge)
To: "David S. Miller" <davem@redhat.com>
Cc: hshmulik@intel.com, bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF1BD71312.6E4C42DC-ON88256CF0.000314A8@us.ibm.com>
From: Jay Vosburgh <fubar@us.ibm.com>
Date: Thu, 20 Mar 2003 16:43:52 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.0 [IBM]|December 16, 2002) at
 03/20/2003 17:44:04
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org









>So when do these changes end up being sent to myself or
>Jeff for mainline inclusion?
>
>I have no objection to the sourceforge project for bonding, but
>I do object to there being such latency between what the sourceforge
>tree has (especially bug fixes) and what gets submitted into the
>mainline.
>
>Personally, I'd prefer that all development occur in the mainline
>tree.  That gives you testing coverage that is impossible otherwise.

      Fair enough; the delay has gotten excessive of late.

      Would it be satisfactory going forward for the sourceforge site to
contain patches to "standard" releases (e.g., 2.4.20), and do updates to
the current development kernel and the sourceforge site simultaneously? In
other words, sourceforge has a patch containing all bonding updates since
2.4.20 (or whichever version) was released, and each time that patch is
updated, the incremental update goes out for inclusion in the development
kernel.

      -J

