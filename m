Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVAaMUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVAaMUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVAaMUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:20:42 -0500
Received: from ns.suse.de ([195.135.220.2]:24797 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261165AbVAaMUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:20:30 -0500
Subject: Re: [PATCH 9/8] lib/sort: turn off self-test
From: Andreas Gruenbacher <agruen@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050131035742.1434944c.pj@sgi.com>
References: <20050131074400.GL2891@waste.org>
	 <20050131035742.1434944c.pj@sgi.com>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107174026.21706.25.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 31 Jan 2005 13:20:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 12:57, Paul Jackson wrote:
> How about just removing the self test, not "#if 0"'ing it out.

I agree with that.

-- Andreas.

