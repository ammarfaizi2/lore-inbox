Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbUBZTNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbUBZTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:13:15 -0500
Received: from [65.248.111.151] ([65.248.111.151]:5128 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S262924AbUBZTNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:13:00 -0500
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: Ben Collins <bcollins@debian.org>
Subject: Re: only ieee1394 from 2.4.20 works for me
Date: Thu, 26 Feb 2004 13:13:38 -0600
User-Agent: KMail/1.6.50
References: <4038BDC3.9030304@kuix.de> <200402260012.25098.brian@brianandsara.net> <20040226131445.GF651@phunnypharm.org>
In-Reply-To: <20040226131445.GF651@phunnypharm.org>
Cc: linux-kernel@vger.kernel.org, kai.engert@gmx.de
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402261313.38565.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 February 2004 07:14, Ben Collins wrote:
> > I however don't have the same problems you describe. Newer versions just
> > simply fail to see anything attached to the ieee1394 bus. I'm using a via
> > epia M10000. I saw a report similar to mine on the 1394 list, but it went
> > unanswered.
>
> Did you cat /proc/bus/ieee1394/devices?

I tried a bunch of stuff, don't remember exactly about this, let me check real 
quick...
Empty.

> Did you try using the rescan-scsi-bus.sh script?

Yeah, ran and reran this, the sbp2 driver never registers itself with the scsi 
subsystem.

--Brian Jackson

-- 
http://www.brianandsara.net
