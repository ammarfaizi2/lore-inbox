Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271140AbTGPVwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271141AbTGPVwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:52:23 -0400
Received: from holomorphy.com ([66.224.33.161]:45029 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271140AbTGPVwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:52:22 -0400
Date: Wed, 16 Jul 2003 15:08:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test1-mm1
Message-ID: <20030716220835.GN15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030715225608.0d3bff77.akpm@osdl.org> <20030716220235.GC1821@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716220235.GC1821@matchmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:02:36PM -0700, Mike Fedyk wrote:
> Hi there.
> I'm having some trouble compiling -mm1
> It looks like it's from the ACPI update.
> More info available upon request.
> gcc version 2.95.4 20011002 (Debian prerelease)
> In file included from arch/i386/mach-generic/probe.c:15:
> include/asm/genapic.h:30: parse error before bitmap'
> include/asm/genapic.h:30: warning: function declaration isn't a prototype
> include/asm/genapic.h:34: parse error before physid_mask_t'
> include/asm/genapic.h:34: warning: no semicolon at end of struct or union
> include/asm/genapic.h:41: parse error before *'
> include/asm/genapic.h:41: warning: type defaults to int' in declaration of
> physid_mask_t'

Okay, tell me about the ACPI update... also if you could send a config
that would help too.


-- wli
