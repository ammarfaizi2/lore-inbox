Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTIRJgm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 05:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbTIRJgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 05:36:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40241 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262092AbTIRJgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 05:36:41 -0400
To: linux-kernel@vger.kernel.org
Cc: Andreas Dilger <adilger@clusterfs.com>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com
Subject: Re: How do I track TG3 peculiarities?
References: <m31xuss0ht.fsf@maxwell.lnxi.com>
	<20030907220926.G18482@schatzie.adilger.int>
	<m1r82llx2i.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Sep 2003 03:36:29 -0600
In-Reply-To: <m1r82llx2i.fsf@ebiederm.dsl.xmission.com>
Message-ID: <m11xuel9pe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And just to wrap this up so no one has a weird feeling.

It turns out there was a Opteron rev B3 errata that was did not have a
work around in LinuxBIOS.  I have talked with AMD and gotten the
information I need to work around the errata. 

And to everyone who gave me hints. 
Thank you.

Eric
