Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVCCL2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVCCL2Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVCCL1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:27:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:36792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261582AbVCCL0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:26:54 -0500
Date: Thu, 3 Mar 2005 03:26:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: ncunningham@cyclades.com
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH]: Speed freeing memory for suspend.
Message-Id: <20050303032620.69add028.akpm@osdl.org>
In-Reply-To: <1109848654.3733.34.camel@desktop.cunningham.myip.net.au>
References: <1109848654.3733.34.camel@desktop.cunningham.myip.net.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:
>
> Here's a patch I've prepared which improves the speed at which memory is
>  freed prior to suspend. It should be a big gain for swsusp.

Patch is simple enough but, as always, please back up an optimization patch
with quantitative test results.

