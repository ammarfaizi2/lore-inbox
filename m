Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUHVLAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUHVLAG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 07:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUHVLAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 07:00:06 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:34054 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266633AbUHVLAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 07:00:01 -0400
Date: Sun, 22 Aug 2004 13:04:01 +0200
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, V13 <v13@priest.com>,
       "Barry K. Nathan" <barryn@pobox.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>
Subject: Re: Possible dcache BUG
Message-ID: <20040822110401.GA14172@hh.idb.hist.no>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040821092556.GA14991@ip68-4-98-123.oc.oc.cox.net> <200408212131.38019.v13@priest.com> <200408211455.14118.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408211455.14118.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 02:55:13PM -0400, Gene Heskett wrote:
> On Saturday 21 August 2004 14:31, V13 wrote:
> 
> So not only has the problem moved from the 2nd LSB to the MSB of the 
> fetch, but it is a lot more severe in terms of the amount of time to 
> catch one error, now nearly 17 hours.  I'm now up 25 hours and the 
> machine feels good, no Oops so far and I've restarted memburn in 
> addition to konstruct working on kde-3.3 final.  I'm over 100 megs 
> into the swap, and 2.6.8.1-mm2 seems to handling the situation 
> admirably so far.  That knocking sound?  Thats me, knocking on wood 
> for good luck.  :-)

Seems it is the memory, then.
Things getting *better*�when moving memory may mean:
* slight timing problem - in that case the memory might be fine
  at a slower setting.  (Reason for complaints if you must go below spec.)
* Moving memory around rubs dirt, dust and oxide off the contacts, both on
  the memory sticks and the mainboard connectors.  This gives
  better contact and may improve things.  Consider cleaning the
  connectors further.  Also look for dust and hair lying in
  the mainboard connectors.  It happens, especially when some
  slots are free for a long time until memory is added.

Helge Hafting



