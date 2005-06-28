Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVF1EBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVF1EBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVF1EBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:01:07 -0400
Received: from [206.246.247.150] ([206.246.247.150]:5045 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262459AbVF1EBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:01:01 -0400
Date: Tue, 28 Jun 2005 00:00:57 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Rog?rio Brito <rbrito@ime.usp.br>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-ID: <20050628040057.GA12499@phunnypharm.org>
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627202226.43ebd761.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could the 1394 guys please suggest what might have caused this?

Unless something is in git that isn't in subversion, nothing has really
changed in the sbp2 module for 5-6 months.

Doesn't appear to be a problem with the ieee1394 subsystem itself (the
cycle master thing isn't all that important), since that would cause not
even being able to send/recv packets.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
