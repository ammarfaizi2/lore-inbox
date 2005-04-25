Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVDYJsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVDYJsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVDYJsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:48:14 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:48402 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262563AbVDYJsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:48:09 -0400
Date: Mon, 25 Apr 2005 11:48:04 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425094804.GA33040@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 10:19:42PM +0100, Al Viro wrote:
> Of course you can.  It does execute the obvious set of rc files.

Is there a possibility for a process to change its namespace to
another existing one?  That would be needed to have a per-user
namespace you go to from rc files or pam.

I'd kinda wonder what happens to pwd.

  OG.

