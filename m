Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVLHKvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVLHKvi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 05:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbVLHKvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 05:51:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:6367 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932067AbVLHKvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 05:51:37 -0500
Date: Thu, 8 Dec 2005 10:51:28 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Felix Oxley <lkml@oxley.org>
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Jon Masters <jonmasters@gmail.com>,
       Grahame White <grahame@regress.homelinux.org>,
       Benjamin LaHaise <bcrl@kvack.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Lars Marowsky-Bree <lmb@suse.de>,
       "linux-os ((Dick Johnson))" <linux-os@analogic.com>,
       Rik van Riel <riel@redhat.com>, Dirk Steuwer <dirk@steuwer.de>,
       Andrea Arcangeli <andrea@suse.de>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: Linux Hardware Quality Labs (was: Linux in a binary world... a doomsday scenario)
Message-ID: <20051208105128.GK27946@ftp.linux.org.uk>
References: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org> <4397E427.2070702@laposte.net> <6A700AF6-1E1B-49A7-A565-336700882097@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6A700AF6-1E1B-49A7-A565-336700882097@oxley.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 10:26:53AM +0000, Felix Oxley wrote:
> I presume that drivers will be developed alongside the hardware  
> because you can't sell the kit until the drivers are on the CD in the  
> nice box with the instruction manual.
> Also you can't test the hardware properly unless you have drivers for  
> it.

No.  Any external reviewer will be immediately put in a nasty position
of standing in the way of vendor's schedule.  That's _the_ recipe for
mess.  And that's besides the joy of NDA, etc.
