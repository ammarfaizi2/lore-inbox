Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTJKPCL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 11:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263320AbTJKPCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 11:02:11 -0400
Received: from ns.suse.de ([195.135.220.2]:21449 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263319AbTJKPCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 11:02:08 -0400
Date: Sat, 11 Oct 2003 17:00:09 +0200
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_AGP_AMD_{8151->K8} Configure.help entry
Message-ID: <20031011150009.GA6674@wotan.suse.de>
References: <20031011121107.GV24300@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011121107.GV24300@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 02:11:07PM +0200, Adrian Bunk wrote:
> In 2.4.23-pre CONFIG_AGP_AMD_8151 was renamed to CONFIG_AGP_AMD_K8, but 
> the configure.help entry was forgotten. he following trivial patch fixes 
> this:

Thanks. Fixed in my tree.

-Andi
