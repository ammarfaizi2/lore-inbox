Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUCHJFs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 04:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUCHJFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 04:05:48 -0500
Received: from styx.suse.cz ([82.208.2.94]:38528 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261719AbUCHJFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 04:05:45 -0500
Date: Mon, 8 Mar 2004 10:05:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ping Cheng <pingc@wacom.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Greg KH '" <greg@kroah.com>
Subject: Re: Wacom USB driver patch
Message-ID: <20040308090549.GC688@ucw.cz>
References: <28E6D16EC4CCD71196610060CF213AEB065BBF@wacom-nt2.wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28E6D16EC4CCD71196610060CF213AEB065BBF@wacom-nt2.wacom.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 05:23:11PM -0800, Ping Cheng wrote:
>  <<linuxwacom.patch>> 
> Attached is a wacom driver patch for kernel 2.6. I have sent my patch to
> Vojtech last year. But, he didn't commit it. I bet he's busy. So, hope
> someone in this list can help me check the code in.
> 
> Please reply to me directly since I am not in linux-kernel mailing list. 
> 
> Thanks!

Sorry for the delay, I merged your patch (with fixes for bugs found by
Pete) today.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
