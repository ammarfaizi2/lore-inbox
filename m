Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270841AbTGPOhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270954AbTGPOg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:36:59 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:28358 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S270943AbTGPOgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:36:52 -0400
Date: Wed, 16 Jul 2003 10:50:50 -0400
From: Ben Collins <bcollins@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] fix warning in iee1394 nodemgr
Message-ID: <20030716145050.GK685@phunnypharm.org>
References: <Pine.LNX.4.53.0307160159330.32541@montezuma.mastecende.com> <20030716141008.GE685@phunnypharm.org> <20030716074637.253ee2fc.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716074637.253ee2fc.davem@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:46:37AM -0700, David S. Miller wrote:
> On Wed, 16 Jul 2003 10:10:08 -0400
> Ben Collins <bcollins@debian.org> wrote:
> 
> > I'm a little concerned that I've never seen either of the two warnings
> > you showed. I've been building with -Werror for awhile now.
> 
> GCC generates slightly different flow graphs on different
> platforms, and from version to version gcc's "might be used
> uninitialized" accuracy varies :-)

Ok, I knew it wouldn't be too long before something forced me to do
non-sparc64 compiles again :)


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
