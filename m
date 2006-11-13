Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933127AbWKMW47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933127AbWKMW47 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933125AbWKMW47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:56:59 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30423 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933123AbWKMW45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:56:57 -0500
Message-ID: <4558F833.4090204@us.ibm.com>
Date: Mon, 13 Nov 2006 16:56:51 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions with patches
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061113221446.GJ22565@stusta.de>
In-Reply-To: <20061113221446.GJ22565@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Subject    : libata must be initialized earlier
> References : http://ozlabs.org/pipermail/linuxppc-dev/2006-November/027945.html
> Submitter  : Paul Mackerras <paulus@samba.org>
> Handled-By : Brian King <brking@us.ibm.com>
> Patch      : http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2
> Status     : patch available

I just resubmitted this patch a few minutes ago.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
