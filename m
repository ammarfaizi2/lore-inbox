Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTFOQaM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTFOQaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:30:12 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:54962 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262366AbTFOQaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:30:08 -0400
Date: Sun, 15 Jun 2003 11:40:26 -0400
From: Ben Collins <bcollins@debian.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: bkSVN live
Message-ID: <20030615154026.GL542@hopper.phunnypharm.org>
References: <20030615133631.GF542@hopper.phunnypharm.org> <Pine.GSO.4.21.0306151839170.14609-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0306151839170.14609-100000@vervain.sonytel.be>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 06:40:46PM +0200, Geert Uytterhoeven wrote:
> On Sun, 15 Jun 2003, Ben Collins wrote:
> > For those that know SVN, you need a recent (e.g. upcoming 0.24 release
> > of SVN, or current trunk) client. I am using revision r6227. If you need
> 
> Can you confirm that 0.23.0 (r5962) (from Debian unstable) is too old, or is
> this a PPC-specific problem?

Too old. 0.24 will release with some incompatible revamps to the ra_svn
protocol, but it improves checkout over high latency by a noticable
amount.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
