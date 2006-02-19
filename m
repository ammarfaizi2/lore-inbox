Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWBSSWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWBSSWo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 13:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWBSSWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 13:22:44 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:48819 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750882AbWBSSWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 13:22:43 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modules with old-style parameters won't load
Date: Sun, 19 Feb 2006 19:22:32 +0100
User-Agent: KMail/1.7.2
Cc: Andreas Gruenbacher <agruen@suse.de>, akpm@osdl.org
References: <200602191839.59667.agruen@suse.de>
In-Reply-To: <200602191839.59667.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602191922.33107.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 February 2006 18:39, Andreas Gruenbacher wrote:
> Just ignore old-style parameter definitions for parameters that aren't 
> actually there.
 
But please tell the user, that his settings are going to be ignored via
printk, instead of silently ignoring him.

Regards


Ingo Oeser

