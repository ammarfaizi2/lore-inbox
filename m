Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVCDFDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVCDFDW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCDFBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:01:36 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:65152 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S262435AbVCDEhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:37:24 -0500
Date: Thu, 3 Mar 2005 23:37:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: George Georgalis <georgalis@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with linux 2.6.11 and sa
Message-ID: <20050304043706.GA10336@havoc.gtf.org>
References: <20050303184605.GB1061@ixeon.local> <d91f4d0c0503031057306a74e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d91f4d0c0503031057306a74e1@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 01:57:28PM -0500, George Georgalis wrote:
> I recall a problem a while back with a pipe from
> /proc/kmsg that was sent by root to a program with a
> user uid. The fix was to run the logging program as
> root. Has that protected pipe method been extended
> since 2.6.8.1?
> 
> I'm very defiantly seeing a problem with the 2.6.11
> kernel and my spamassassin setup. However, it's not
> clear exactly where the problem is, seems like sa
> but it might be 2.6.11 with daemontools + qmail +
> QMAIL_QUEUE.

Does reverting to 2.6.10 fix this behavior?

	Jeff



