Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbTLRWVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbTLRWVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:21:15 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:29079 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265354AbTLRWVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:21:14 -0500
Date: Wed, 17 Dec 2003 09:10:57 -0500
From: Ben Collins <bcollins@debian.org>
To: Dale K Dicks <dale_d@telusplanet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 subsystem causes segfaults
Message-ID: <20031217141057.GC551@phunnypharm.org>
References: <1071670222.2519.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071670222.2519.5.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 5. no oops message

Not sure how things can segv without some sort of kernel message. Are
you sure it didn't print anything at all?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
