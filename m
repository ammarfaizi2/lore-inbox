Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263483AbUDZUdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUDZUdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbUDZUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:33:44 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:58513 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S263483AbUDZUdk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:33:40 -0400
Subject: Re: [PATCH 1/11] sunrpc-enosys-when-unavail
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1082975161.3295.70.camel@winden.suse.de>
References: <1082975161.3295.70.camel@winden.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083011614.15282.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 16:33:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 06:28, Andreas Gruenbacher wrote:
> Differentiate between program/procedure not available and other errors
> 

Sorry. This one is unacceptable. I will NOT have program numbers hard
coded into sunrpc. There should be no reason to do this at all...

Cheers,
  Trond
