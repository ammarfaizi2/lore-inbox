Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbTE2LPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTE2LPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:15:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32165 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262163AbTE2LOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:14:07 -0400
Date: Thu, 29 May 2003 04:26:15 -0700 (PDT)
Message-Id: <20030529.042615.55727031.davem@redhat.com>
To: pavel@suse.cz
Cc: ak@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030529112517.GC1215@elf.ucw.cz>
References: <p73wuga6rin.fsf@oldwotan.suse.de>
	<20030529.023203.41634240.davem@redhat.com>
	<20030529112517.GC1215@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Thu, 29 May 2003 13:25:17 +0200
   
   What is copy_in_user?

Both source and destination pointers are in userspace.
