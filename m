Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVAGT5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVAGT5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVAGT4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:56:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23738 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261580AbVAGTzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:55:09 -0500
Date: Fri, 7 Jan 2005 15:05:14 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: Fix for new elf_loader bug?
Message-ID: <20050107170514.GJ29176@logos.cnet>
References: <41DEAF8F.3030107@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DEAF8F.3030107@bio.ifi.lmu.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 04:49:35PM +0100, Frank Steiner wrote:
> Hi,
> 
> is there already a patch for the new problem with the elf loader, maybe
> in the bitkeeper tree?
> 
> http://www.isec.pl/vulnerabilities/isec-0021-uselib.txt

2.6.10-ac6 contains a fix for the problem - a similar version should hit the BK tree 
RSN.

