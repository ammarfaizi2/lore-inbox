Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265102AbTGBQY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTGBQY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:24:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:41960 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265102AbTGBQY4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:24:56 -0400
Date: Wed, 2 Jul 2003 09:38:46 -0700
From: Greg KH <greg@kroah.com>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.73 - Won't compile using oldconfig - config attached
Message-ID: <20030702163846.GA8498@kroah.com>
References: <003201c33970$21f57280$0200a8c0@wsl3> <m3k7b12e5i.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3k7b12e5i.fsf@ccs.covici.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:31:53AM -0400, John Covici wrote:
> Anyone have an answer to this one?  I am getting the same error as
> below.

Fixed in the -bk tree.  Search the lkml archives for the patch if you
are curious.

thanks,

greg k-h
