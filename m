Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVAJJAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVAJJAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 04:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVAJJAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 04:00:39 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:57752 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262158AbVAJJAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 04:00:35 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 10 Jan 2005 09:50:18 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] bttv-cards.c: #if 0 function bttv_reset_audio (fwd)
Message-ID: <20050110085018.GA19858@bytesex>
References: <20050108012900.GM14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050108012900.GM14108@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 02:29:00AM +0100, Adrian Bunk wrote:
> The patch forwarded below still applies and compiles against 2.6.10-mm2.

And it's still wrong, bttv_reset_audio() is not superfluous.

> Please apply.

No.

  Gerd

