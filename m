Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUDFW0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264046AbUDFW0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:26:09 -0400
Received: from sinfonix.rz.tu-clausthal.de ([139.174.2.33]:45786 "EHLO
	sinfonix.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S264044AbUDFW0D convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:26:03 -0400
From: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
To: Dave Jones <davej@redhat.com>, Bjoern Michaelsen <bmichaelsen@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Date: Wed, 7 Apr 2004 00:26:00 +0200
User-Agent: KMail/1.6.1
References: <20040406031949.GA8351@lord.sinclair> <200404070001.35514.volker.hemmann@heim10.tu-clausthal.de> <20040406221403.GB10142@redhat.com>
In-Reply-To: <20040406221403.GB10142@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404070026.00589.volker.hemmann@heim10.tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 April 2004 00:14, Dave Jones wrote:
> On Wed, Apr 07, 2004 at 12:01:35AM +0200, Hemmann, Volker Armin wrote:
>  > ok, I was a little confused so:
>  > vanilla 2.6.5+this patch: old testgart garbeling problem again
>  > patched 2.6.5-rc3+this patch: everything fine
>  > vanilla 2.6.5+agpgart-2004-04-06.diff+ this patch: everything fine, too
>
> Ah yes, sorry I should've mentioned you need the other parts.
> This is as expected. I'll push this out. Thanks for your
> testing, and your patience 8-)
>
> 		Dave

no problem, I am the one who needs the support and is to dumb to do it 
himself ;o)

If you have more patches you want to get tested, just send them.. with fs or 
ide-patches I would be a lot more reluctant ;o)

Glück Auf
Volker

-- 
Conclusions 
 In a straight-up fight, the Empire squashes the Federation like a bug. Even 
with its numerical advantage removed, the Empire would still squash the 
Federation like a bug. Accept it. -Michael Wong 
