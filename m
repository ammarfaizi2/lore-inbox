Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266960AbUAXQ22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 11:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266961AbUAXQ22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 11:28:28 -0500
Received: from colino.net ([62.212.100.143]:61173 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S266960AbUAXQ20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 11:28:26 -0500
Date: Sat, 24 Jan 2004 17:28:00 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hugang <hugang@soulinfo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040124172800.43495cf3@jack.colino.net>
In-Reply-To: <1074912854.834.61.camel@gaston>
References: <20040119105237.62a43f65@localhost>
	<1074483354.10595.5.camel@gaston>
	<1074489645.2111.8.camel@laptop-linux>
	<1074490463.10595.16.camel@gaston>
	<1074534964.2505.6.camel@laptop-linux>
	<1074549790.10595.55.camel@gaston>
	<20040122211746.3ec1018c@localhost>
	<1074841973.974.217.camel@gaston>
	<20040123183030.02fd16d6@localhost>
	<1074912854.834.61.camel@gaston>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jan 2004 at 13h01, Benjamin Herrenschmidt wrote:

Hi, 

> The patch is against my tree currently, and the arch/ppc/kernel/pmdisk.S file
> is appended as-is (not in patch form). 

Didn't you forget to include include/asm-ppc/suspend.h ? ;-)
-- 
Colin
