Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWADKFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWADKFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbWADKFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:05:35 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:34293 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1751234AbWADKFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:05:35 -0500
Date: Wed, 4 Jan 2006 11:05:24 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>,
       linux-kernel@vger.kernel.org,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [Patch] es7000 broken without acpi
Message-ID: <20060104100523.GA27056@brainysmurf.cs.umu.se>
References: <1134427819.18385.2.camel@alice> <20060103154808.5ca0d1a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060103154808.5ca0d1a4.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 03:48:08PM -0800, Andrew Morton wrote:
> 
> I believe that es7000 requires ACPI, so a better fix would be to enforce
> that within Kconfig.
> 
> Natalie, can you please comment?
> 

This was discussed back in October [1], but nothing became of it. Should
I resend the patch perhaps?

	Peter

[1] http://marc.theaimsgroup.com/?t=112928755800002&r=1&w=2

-- 
Peter Hagervall......................email: hager@cs.umu.se
Department of Computing Science........tel: +46(0)90 786 7018
University of Umeå, SE-901 87 Umeå.....fax: +46(0)90 786 6126
