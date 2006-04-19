Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWDSLlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWDSLlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 07:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWDSLlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 07:41:14 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:60126 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750704AbWDSLlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 07:41:13 -0400
Date: Wed, 19 Apr 2006 06:41:06 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: Kyle Moffett <mrmacman_g4@mac.com>, casey@schaufler-ca.com,
       James Morris <jmorris@namei.org>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060419114106.GC20481@sergelap.austin.ibm.com>
References: <20060419014857.35628.qmail@web36606.mail.mud.yahoo.com> <CD11FD59-4E2E-4AD7-9DD0-5811CE792B24@mac.com> <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604190656.k3J6uSGW010288@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu):
> On Wed, 19 Apr 2006 02:40:25 EDT, Kyle Moffett said:
> > Perhaps the SELinux model should be extended to handle (dir-inode,
> > path-entry) pairs.  For example, if I want to protect the /etc/shadow
> > file regardless of what tool is used to safely modify it, I would set
> 
> Some of us think that the tools can protect /etc/shadow just fine on their
> own, and are concerned with rogue software that abuses /etc/shadow without
> bothering to safely modify it..

Can you rephrase this?  I'm don't understand what you're saying...

My default response would have to be:

> own, and are concerned with rogue software that abuses /etc/shadow without
> bothering to safely modify it..

rogue software like vi?

thanks,
-serge
