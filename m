Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937061AbWLDQQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937061AbWLDQQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937060AbWLDQQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:16:33 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:37234 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937061AbWLDQQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:16:32 -0500
Date: Mon, 4 Dec 2006 11:16:16 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Sven Geggus <sven-im-usenet@gegg.us>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: nfs-related kernel NULL pointer dereference
Message-ID: <20061204161616.GA1830@filer.fsl.cs.sunysb.edu>
References: <ekpeot$caj$1@ultimate100.geggus.net> <1164986631.5761.93.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164986631.5761.93.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 10:23:51AM -0500, Trond Myklebust wrote:
> On Fri, 2006-12-01 at 14:38 +0000, Sven Geggus wrote:
> > Hello,
> > 
> > while trying to boot Kernel 2.6.19 (vanilla+unionfs) I get the following
> > NULL pointer dereferences:
> 
> Are you able to reproduce this without unionfs?

If not, you'd be better off asking the Unionfs list (unionfs.org).

Josef "Jeff" Sipek.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
