Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbTFRVCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbTFRVCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:02:33 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:9935 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265533AbTFRVCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:02:32 -0400
Date: Wed, 18 Jun 2003 16:09:24 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: SCM domains [was Re: Linux 2.5.71]
Message-ID: <20030618200923.GR542@hopper.phunnypharm.org>
References: <20030615002153.GA20896@work.bitmover.com> <20030618013940.GA19176@work.bitmover.com> <3EEFC6A3.5010406@zytor.com> <20030618011455.GF542@hopper.phunnypharm.org> <bcooor$pbj$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcooor$pbj$1@cesium.transmeta.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 09:11:07PM -0700, H. Peter Anvin wrote:
> Followup to:  <20030618011455.GF542@hopper.phunnypharm.org>
> By author:    Ben Collins <bcollins@debian.org>
> In newsgroup: linux.dev.kernel
> > > 
> > > I have no problem setting up CNAMEs in kernel.org if people are OK with
> > > it.  Setting up actual servers is another matter.
> > 
> > CNAMES on kernel.org would be perfect.
> > 
> 
> So right now cvs, svn and bk all -> kernel.bkbits.net?

And for those that want to switch their SVN repo to the new URL:

# cd linux-2.5-bksvn
# svn switch --relocate svn://kernel.bkbits.net/linux-2.5/trunk \
	svn://svn.kernel.org/linux-2.5/trunk

For 2.4, it should be obvious.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
