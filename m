Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTDWSrw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264273AbTDWSrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:47:52 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:3278 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S264271AbTDWSrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:47:49 -0400
Subject: Re: [PATCH] Extended Attributes for Security Modules against 2.5.68
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, "Ted Ts'o" <tytso@mit.edu>,
       Andreas Gruenbacher <a.gruenbacher@computer.org>,
       Stephen Tweedie <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
In-Reply-To: <20030423194254.A5295@infradead.org>
References: <1051120322.14761.95.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423191749.A4244@infradead.org>
	 <1051122958.14761.110.camel@moss-huskers.epoch.ncsc.mil>
	 <20030423194254.A5295@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1051124367.14761.125.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 14:59:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-23 at 14:42, Christoph Hellwig wrote:
> No.  It's not acceptable that the same ondisk structure has a different
> meaning depending on loaded modules.  If the xattrs have a different
> meaning they _must_ have a different name.

Again, I'd suggest that you read the original discussion thread.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

