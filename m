Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVF1QPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVF1QPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVF1QPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:15:06 -0400
Received: from [206.246.247.150] ([206.246.247.150]:60342 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262111AbVF1QPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:15:01 -0400
Date: Tue, 28 Jun 2005 12:15:01 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-ID: <20050628161500.GA25788@phunnypharm.org>
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org> <20050628040057.GA12499@phunnypharm.org> <20050628061245.GA5696@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628061245.GA5696@ime.usp.br>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 03:12:45AM -0300, Rog?rio Brito wrote:
> On Jun 28 2005, Ben Collins wrote:
> > Unless something is in git that isn't in subversion, nothing has really
> > changed in the sbp2 module for 5-6 months.
> 
> Is there any other information that I can provide you with that would help
> track this?

Diff git2's ieee1394 directory and the SVN repo from linux1394.org if you
could.

> > Doesn't appear to be a problem with the ieee1394 subsystem itself (the
> > cycle master thing isn't all that important), since that would cause not
> > even being able to send/recv packets.
> 
> So, could this be a problem with the SCSI layer, then?

Doubtful.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
