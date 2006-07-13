Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWGMTXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWGMTXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbWGMTXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:23:18 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:60879 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030305AbWGMTXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:23:17 -0400
Date: Thu, 13 Jul 2006 21:23:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-kernel@vger.kernel.org, kai@germaschewski.name
Subject: Re: ./scripts/kallsyms.c question
Message-ID: <20060713192310.GA312@mars.ravnborg.org>
References: <6.1.1.1.0.20060709193540.01ec8370@ptg1.spd.analog.com> <6.1.1.1.0.20060710023042.01ec9eb0@ptg1.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.1.1.1.0.20060710023042.01ec9eb0@ptg1.spd.analog.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 02:36:15AM -0400, Robin Getz wrote:
> Sam wrote:
> >Keep the existing if/else - it is still readable.
> >But please add a comment describing that it is blackfin that requires 
> >these two odd sections.
> 
> OK - here you go...
Thanks. But I'm missing a "signed-off-by: line as per
Documentation/SubmittingPatches.
Please resend with proper changlog and signed-off-by line.

	Sam
