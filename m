Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264392AbUEMSr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbUEMSr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 14:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUEMSr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 14:47:27 -0400
Received: from ozlabs.org ([203.10.76.45]:19344 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264392AbUEMSrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 14:47:25 -0400
Date: Fri, 14 May 2004 04:43:18 +1000
From: Anton Blanchard <anton@samba.org>
To: Zoltan.Menyhart@bull.net
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Who owns those locks ?
Message-ID: <20040513184318.GG11588@krispykreme>
References: <40A1F4BE.4A298352@nospam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A1F4BE.4A298352@nospam.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why don't you put the ID of the owner of the lock in the lock word ?
> Here is your patch for IA-64.
> Doesn't cost any additional instruction, you can have it in your
> "production" kernel, too.

We already do this on ppc64.

Anton
