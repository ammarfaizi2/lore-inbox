Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVAFMsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVAFMsM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 07:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVAFMsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 07:48:12 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:62746 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262812AbVAFMsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 07:48:08 -0500
Date: Thu, 6 Jan 2005 13:48:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm2
Message-ID: <20050106124851.GA8063@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050106002240.00ac4611.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 12:22:40AM -0800, Andrew Morton wrote:
>  bk-kconfig.patch

Improves the search function in menuconfig - better display of what
a symbol depends on / selects.
Also display the same information when getting help on a symbol.

Try it out next time you start up menuconfig.

Kudos to Roman Zippel for implementing the core functionality.

	Sam
