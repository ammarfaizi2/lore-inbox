Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbUBXPYy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUBXPYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:24:54 -0500
Received: from mail.ccur.com ([208.248.32.212]:33042 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262268AbUBXPYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:24:52 -0500
Date: Tue, 24 Feb 2004 10:24:51 -0500
From: Joe Korty <joe.korty@ccur.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] SCSI update for 2.6.3
Message-ID: <20040224152451.GA21699@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1077596668.1983.282.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077596668.1983.282.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 10:24:27PM -0600, James Bottomley wrote:
> The current crop of accumulated patches are mainly driver updates and
> bug fixes.
> 
> It is available at
> 
> bk://linux-scsi.bkbits.net/scsi-for-linus
> 
> The short changelog is:
> 
> James Bottomley:
>   o MPT Fusion driver 3.00.03 update

Hi James,
 I am getting a panic out of the 2.6.3 Fusion driver when no devices
are attached to it.  Does the above update fix it?  If so, I would
like to get a copy of the above in patch form.  If not, I can send
you a copy of my boot log.

Regards,
Joe
