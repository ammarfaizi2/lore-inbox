Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbTGMNWs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 09:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267293AbTGMNWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 09:22:48 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31892 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266555AbTGMNWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 09:22:44 -0400
Date: Sun, 13 Jul 2003 14:37:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@codemonkey.org.uk>, Jan Dittmer <j.dittmer@portrix.net>,
       linux-kernel@vger.kernel.org
Subject: Re: agpgart, nforce2, radeon and agp fastwrite
Message-ID: <20030713133720.GE19132@mail.jlokier.co.uk>
References: <3F102E8E.4030507@portrix.net> <20030712202622.GB7741@suse.de> <3F10793E.5080202@portrix.net> <20030712211721.GA10207@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030712211721.GA10207@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Girr. I'm not entirely happy about exporting that if I can help it.
> It's annoying that the nvidia_insert_memory() routine is 99% the same
> as the generic routine. If it could use that, we'd not have to worry
> about the export.

Is it time to teach the module loader how to patch certain binaries? :)

-- Jamie
