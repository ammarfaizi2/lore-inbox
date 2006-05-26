Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWEZHfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWEZHfE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWEZHfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:35:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62371 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750709AbWEZHfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:35:03 -0400
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] i386/x86-64 Add nmi watchdog support for new Intel CPUs
Date: Fri, 26 May 2006 09:34:38 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20060514185023.A16695@unix-os.sc.intel.com> <200605150922.25511.ak@suse.de> <20060525155450.A9360@unix-os.sc.intel.com>
In-Reply-To: <20060525155450.A9360@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605260934.38275.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 00:54, Venkatesh Pallipadi wrote:
> 
> On Mon, May 15, 2006 at 09:22:25AM +0200, Andi Kleen wrote:
> > 
> > Can you regenerate it against the latest firstfloor tree please? 
> > With Don's x86-64 NMI changes there are a zillion rejects.
> > 
> 
> Below is the updated patch, to apply over Don's changes.

Applied thanks

-Andi
