Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTFCAtN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 20:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264607AbTFCAtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 20:49:13 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:3795 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264605AbTFCAtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 20:49:10 -0400
Date: Mon, 2 Jun 2003 20:03:40 -0400
From: Ben Collins <bcollins@debian.org>
To: Rob Landley <rob@landley.net>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org
Subject: Re: BKCVS issue
Message-ID: <20030603000340.GU10102@phunnypharm.org>
References: <20030602211436.GF14878@vitelus.com> <200306021937.03013.rob@landley.net> <20030602233901.GT10102@phunnypharm.org> <200306022050.51909.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306022050.51909.rob@landley.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The problem is that bkcvs 2.5 is broken. Larry has said he will fix it,
> > time permitting.
> 
> I was under the impression that the problem in bkcvs was a design issue: it 
> converted a BK repository to a CVS repository by creating a fresh CVS 
> repository from scratch each time.  It didn't modify an existing CVS 
> repository, which would be a bit more work.

That would be pretty rediculous, not to mention impossible for CVS
itself to handle on the client end.

No, for real, bkcvs-2.5 is broken. I already emailed Larry about it. He
acknowledged it, and it's just a matter of time before it's fixed.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
