Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbTGDK4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 06:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265975AbTGDK4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 06:56:06 -0400
Received: from holomorphy.com ([66.224.33.161]:57297 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265980AbTGDK4D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 06:56:03 -0400
Date: Fri, 4 Jul 2003 04:10:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <20030704111022.GE26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <3F054109.2050100@aitel.hist.no> <20030704093531.GA26348@holomorphy.com> <20030704095004.GB26348@holomorphy.com> <20030704100217.GC26348@holomorphy.com> <20030704100749.GD26348@holomorphy.com> <3F05610C.4050202@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F05610C.4050202@aitel.hist.no>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 01:12:12PM +0200, Helge Hafting wrote:
> I applied both of your recent patches, and the patched
> 2.5.74-mm1 kernel came up fine. :-)

Terrific!

Sorry about the confusion at first. I apparently made a boo boo when
sizing the physid maps as NR_CPUS bits.


-- wli
