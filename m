Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275155AbRIZMeT>; Wed, 26 Sep 2001 08:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275157AbRIZMd6>; Wed, 26 Sep 2001 08:33:58 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:14935 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S275155AbRIZMdx>;
	Wed, 26 Sep 2001 08:33:53 -0400
Message-ID: <20010926143435.A1860@win.tue.nl>
Date: Wed, 26 Sep 2001 14:34:35 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Kamil Toman <ktoman@email.cz>, linux-kernel@vger.kernel.org
Subject: Re: keyboard state
In-Reply-To: <20010926102611.A23196@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010926102611.A23196@artax.karlin.mff.cuni.cz>; from Kamil Toman on Wed, Sep 26, 2001 at 10:26:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 10:26:11AM +0200, Kamil Toman wrote:

> but we need (obvious from the URLed picture) at least
> - key itself
> - SHIFTed key
> - key when CAPSLOCK is on
> - SHIFTed key while CAPSLOCK is on
> 
> This could be for examle solved with a slight modification of keyboard.c.

I think you can do all you want using loadkeys.
No kernel changes required.

Andries


[For further discussion, mail aeb@cwi.nl - letters sent here
are mostly lost.]
