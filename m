Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbVD3CE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbVD3CE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 22:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVD3CE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 22:04:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20451 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263128AbVD3CEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 22:04:40 -0400
Subject: Re: Linux 2.6.11.8
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       stable@kernel.org
In-Reply-To: <20050430015732.GA8943@kroah.com>
References: <20050430015732.GA8943@kroah.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 22:04:38 -0400
Message-Id: <1114826678.8636.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 18:57 -0700, Greg KH wrote:
> As the -stable patch review cycle is now over, I've released the
> 2.6.11.8 kernel in the normal kernel.org places.  Due to some
> disagreement over some of the patches in the review cycle, I've dropped
> a number of them.
> 

Why didn't the fix for losing the keyboard when unplugging a USB audio
device go in?  That was a serious bug that bit many, many users.

Lee

