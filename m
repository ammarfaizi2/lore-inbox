Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbUKXRZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbUKXRZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbUKXRZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:25:23 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:56449 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262773AbUKXRUH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:20:07 -0500
X-Envelope-From: kraxel@bytesex.org
To: Gregor Jasny <jasny@vidsoft.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in bttv (Linux 2.6.10-rc2-bk3)
References: <41A4B085.20109@vidsoft.de>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 24 Nov 2004 18:13:53 +0100
In-Reply-To: <41A4B085.20109@vidsoft.de>
Message-ID: <87mzx7dvam.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregor Jasny <jasny@vidsoft.de> writes:

> My machine oopsed during an VIDIOCMCAPTURE or an VIDIOCSYNC ioctl.
> ksymoops 2.4.9 on i686 2.6.10-rc2-bk3.  Options used

most likely fixed meanwhile, try a newer -bk snapshot.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
