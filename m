Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbTFHQpR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 12:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTFHQpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 12:45:17 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:44037 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262830AbTFHQpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 12:45:14 -0400
Date: Sun, 8 Jun 2003 17:58:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Gergely Madarasz <gorgo@itc.hu>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] let COMX depend on PROC_FS
Message-ID: <20030608175850.A9513@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, Gergely Madarasz <gorgo@itc.hu>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	trivial@rustcorp.com.au
References: <20030608144038.GF16164@fs.tum.de> <20030608174908.A9377@infradead.org> <20030608165608.GI16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030608165608.GI16164@fs.tum.de>; from bunk@fs.tum.de on Sun, Jun 08, 2003 at 06:56:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 06:56:08PM +0200, Adrian Bunk wrote:
> The proc_get_inode link problem only affects the modular build of 
> comx.c .

But it's still broken :)  This just shows no one actually tested
it with actual hardware.

