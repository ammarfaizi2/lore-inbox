Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUFWT5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUFWT5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266634AbUFWT5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:57:45 -0400
Received: from gatekeeper.excelhustler.com ([68.99.114.105]:55988 "EHLO
	gatekeeper.elmer.external.excelhustler.com") by vger.kernel.org
	with ESMTP id S266633AbUFWT5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:57:43 -0400
Date: Wed, 23 Jun 2004 14:57:29 -0500
From: John Goerzen <jgoerzen@complete.org>
To: linux-kernel@vger.kernel.org
Subject: Buffers permanently at 4k in top
Message-ID: <20040623195729.GA1907@excelhustler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a 2.4.26 system, just installed.  In top, I see the value for
buffers permanently at 4k.  The cached value often is up in hundreds of
megabytes, but buffers stays at 4k constantly.

This seems bad, and I'm wondering why it's doing this and how it could
be fixed.

Hardware is a HP/Compaq Proliant ML350 G3 server with dual P4 Xeon CPUs
and 2GB RAM.

Thanks,
John

