Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVG1Rpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVG1Rpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVG1Rpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:45:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261856AbVG1RoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:44:20 -0400
Date: Thu, 28 Jul 2005 10:43:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: Broke nice range for RLIMIT NICE
Message-Id: <20050728104316.02c7aba5.akpm@osdl.org>
In-Reply-To: <32710.1122563064@www32.gmx.net>
References: <32710.1122563064@www32.gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kerrisk" <mtk-manpages@gmx.net> wrote:
>
> (A passing note to all kernel developers: when 
>  making changes that affect userland-kernel interfaces, please 
>  send me a man-pages patch, or at least a notification of the 
>  change, so that some information makes its way into the manual 
>  pages).

Could I suggest that you send in a MAINTANERS record?  That might help a bit.
