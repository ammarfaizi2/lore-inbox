Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTF0Unw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTF0Unw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:43:52 -0400
Received: from smtp0.libero.it ([193.70.192.33]:12012 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S264786AbTF0Unv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:43:51 -0400
Subject: Re: PPP Modem connection impossible with 2.5.73-bk2
From: Flameeyes <daps_mls@libero.it>
To: Matthew Harrell 
	<mharrell-dated-1057177236.425fdb@bittwiddlers.com>
Cc: diegocg@teleline.es, Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030627202032.GA28863@bittwiddlers.com>
References: <1056567978.931.8.camel@laurelin>
	 <20030626195238.673bcffd.diegocg@teleline.es>
	 <20030626164116.1bfbad1e.shemminger@osdl.org>
	 <20030627022837.3dca1b09.diegocg@teleline.es>
	 <20030627202032.GA28863@bittwiddlers.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1056747440.1734.32.camel@laurelin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 27 Jun 2003 22:57:21 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-27 at 22:20, Matthew Harrell wrote:
> Let me know if there's anything else I can check.
The only way I found is to take the drivers/net/ppp_generic.c from the
original 2.5.73.
Neither the patch sent me by Diego Calleja García works :/
-- 
Flameeyes <dgp85@users.sf.net>

