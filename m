Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUCVW4t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUCVW4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:56:49 -0500
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:46602 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S261234AbUCVW4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:56:48 -0500
Subject: Re: OSS: cleanup or throw away
From: Luiz Fernando Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Adrian Bunk <bunk@fs.tum.de>, jos@hulzink.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040322232723.780ab026.diegocg@teleline.es>
References: <200403221955.52767.jos@hulzink.net>
	 <20040322215709.GT16746@fs.tum.de>
	 <20040322232723.780ab026.diegocg@teleline.es>
Content-Type: text/plain; charset=iso-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1079996074.29535.8.camel@telecentrolivre>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Mar 2004 19:54:34 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2004-03-22 às 19:27, Diego Calleja García escreveu:
> El Mon, 22 Mar 2004 22:57:09 +0100 Adrian Bunk <bunk@fs.tum.de> escribió:
> 
> > OSS will stay in 2.6 (2.6 is a stable kernel series) but it will most
> > likely be removed in 2.7.
> 
> Personally, as an user, I'd like to have the OSS drivers which don't have
> a ALSA equivalent for my old hardware. There're several
> sound cards with both ALSA and OSS drivers where ALSA works
> much better 99% of the time. Those could be safely removed
> (even in the 2.6 timeframe, I'd argue) but I'd like to keep the ones
> without an alsa equivalent for my old hardware (specially now that we
> have a -tiny tree ;) however I can understand that if they don't
> have a maintainer they'll get removed...

 Also, I think is not good for the kernel to have code that does not
compile and/or compile with several warnings.

 So, if someone have time to work on it, is not bad.

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

