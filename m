Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVCNVpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVCNVpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVCNVpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:45:05 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:5001 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261960AbVCNVn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:43:26 -0500
Date: Mon, 14 Mar 2005 22:43:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: [patch 2.6.11-rc5] Add target debug_kallsyms
Message-ID: <20050314214341.GF17925@mars.ravnborg.org>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Linux/m68k <linux-m68k@vger.kernel.org>
References: <19472.1109415002@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19472.1109415002@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 09:50:02PM +1100, Keith Owens wrote:
> Make it easier to generate maps for debugging kallsyms problems.
> debug_kallsyms is only a debugging target so no help or silent mode.
> 
> Signed-off-by: Keith Owens <kaos@ocs.com.au>
Applied to my kbuild tree.
I will remove it when we stop see kallsyms reports.

	Sam
