Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTDXQeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTDXQeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:34:23 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:39179 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S263745AbTDXQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:34:22 -0400
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16040.5351.773075.771381@chiark.greenend.org.uk>
Date: Thu, 24 Apr 2003 17:46:31 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: rename("a","b") succeeds multiple times race
In-Reply-To: <20030424143058.GC23247@spackhandychoptubes.co.uk>
References: <16039.53523.533498.354359@chiark.greenend.org.uk>
	<20030424143058.GC23247@spackhandychoptubes.co.uk>
X-Mailer: VM 7.03 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Sykes writes ("Re: rename("a","b") succeeds multiple times race"):
> In rename(2):

Linux manpages are hardly a definitive reference for the desired
behaviour of system calls !  Unfortunately SuSv2 and v3 are
unhelpfully vague.

Ian.
