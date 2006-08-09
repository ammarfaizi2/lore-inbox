Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWHIRiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWHIRiv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWHIRiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:38:51 -0400
Received: from mail.linicks.net ([217.204.244.146]:34771 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751177AbWHIRiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:38:50 -0400
From: Nick Warne <nick@linicks.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Still get build warnings - gcc-3.4.6 - 2.6.17.8
Date: Wed, 9 Aug 2006 18:38:44 +0100
User-Agent: KMail/1.9.4
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <200608082148.11433.nick@linicks.net> <20060808141246.25ee5db7.rdunlap@xenotime.net> <20060808231915.GA23161@kroah.com>
In-Reply-To: <20060808231915.GA23161@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608091838.44989.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 00:19, Greg KH wrote:

> > fwiw, I don't seem to have any patches to fix/remove them.
>
> pm_unregister_all is removed in the -mm tree, from a patch in my tree.
>

OK, thanks all.  For love nor money could I find the mail/patch somebody sent 
me ages ago for this... but anyway, it's been sorted now.

Nick
-- 
Every program has two purposes:
one for which it was written and another for which it wasn't.
