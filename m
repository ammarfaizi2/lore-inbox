Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUEaRwC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUEaRwC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 13:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbUEaRwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 13:52:02 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:42145 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264705AbUEaRv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 13:51:59 -0400
Date: Mon, 31 May 2004 10:51:51 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Ooops w/2.6.7-rc2 & XFS
Message-ID: <20040531175151.GA27164@taniwha.stupidest.org>
References: <20040531023225.93772.qmail@web90002.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531023225.93772.qmail@web90002.mail.scd.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 07:32:25PM -0700, Phy Prabab wrote:

> I unmounted and repaired which allowed the unit to run
> for another couple of hours only to get hosed again
> with the above trace.

repaired == xfs_repair?  what did that say?

> Any suggestions?

this machine has ECC/whatever and memtest86 passes cleanly right?
also, when the error occured again was it exactly the same both times?


thanks,

  --cw
