Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbULOBAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbULOBAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbULOA7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:59:53 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:8462 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261795AbULOA4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:56:00 -0500
Date: Tue, 14 Dec 2004 19:57:22 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: frahm@irsamc.ups-tlse.fr, linux-kernel@vger.kernel.org, jgarzik@pobox.org
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
Message-ID: <20041215005722.GE4357@tuxdriver.com>
Mail-Followup-To: Grant Grundler <grundler@parisc-linux.org>,
	frahm@irsamc.ups-tlse.fr, linux-kernel@vger.kernel.org,
	jgarzik@pobox.org
References: <20041212214803.GB22514@colo.lackof.org> <200412130313.iBD3DAF4004365@albireo.free.fr> <20041213035936.GB26501@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213035936.GB26501@colo.lackof.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 08:59:36PM -0700, Grant Grundler wrote:

> But still, I'm hopeing for two code changes as a result:
> 1) include CSR5 and CSR6 in the printk output
> 2) the date of the tulip driver revision needs to be updated (or dropped).

Patches?

If you don't want to post them publicly yourself, send them to me
and I'll be happy to test/package/post them...

John
-- 
John W. Linville
linville@tuxdriver.com
