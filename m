Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752153AbWCCCcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbWCCCcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 21:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752146AbWCCCcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 21:32:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14988 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752153AbWCCCcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 21:32:07 -0500
Date: Thu, 2 Mar 2006 18:30:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH 7/15] EDAC: i82875p cleanup
Message-Id: <20060302183044.459ddb13.akpm@osdl.org>
In-Reply-To: <200603021748.01132.dsp@llnl.gov>
References: <200603021748.01132.dsp@llnl.gov>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Peterson <dsp@llnl.gov> wrote:
>
>  +#ifdef CORRECT_BIOS
>  +fail0:
>  +#endif

What is CORRECT_BIOS?  Is the fact that it's never defined some sort of
commentary?  ;)

