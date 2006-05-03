Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965206AbWECOvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965206AbWECOvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWECOvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:51:15 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:55513 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965206AbWECOvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:51:14 -0400
Date: Wed, 3 May 2006 10:51:12 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Al Viro <viro@ftp.linux.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Steve Grubb <sgrubb@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jon Smirl <jonsmirl@gmail.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 11/14] Reworked patch for labels on user space messages
In-Reply-To: <1146667956.27735.73.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.64.0605031050500.17601@d.namei>
References: <E1FaVfH-000531-LX@ZenIV.linux.org.uk> 
 <9e4733910605030711p2acab747g8f2ea7fdbb95f3c4@mail.gmail.com> 
 <20060503142802.GD27946@ftp.linux.org.uk> <1146667956.27735.73.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006, Stephen Smalley wrote:

> [patch 1/1] selinux:  Clear selinux_enabled flag upon runtime disable.
> 
> Clear selinux_enabled flag upon runtime disable of SELinux by userspace,
> and make sure it is defined even if selinux= boot parameter support is
> not enabled in configuration.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: James Morris <jmorris@namei.org>



-- 
James Morris
<jmorris@namei.org>
