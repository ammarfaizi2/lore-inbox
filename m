Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVBAAP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVBAAP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVBAAOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:14:15 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:22934 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261479AbVBAAJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:09:18 -0500
Date: Tue, 1 Feb 2005 00:02:48 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, davem@redhat.com, jgarzik@pobox.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] move dp83840.h to Documentation/
Message-ID: <20050201000248.GA13862@linux-mips.org>
References: <20050131234158.GI21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131234158.GI21437@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 12:41:58AM +0100, Adrian Bunk wrote:

> 
> dp83840.h is included once but none of the definitions it contains is
> actually used.
> 
> Ralf Baechle wants that it stays as documentation, so this patch moves 
> it under Documentation/ .

Under Documentation is certainly not the right place for a piece of code,
so let's do it as David says.

  Ralf
