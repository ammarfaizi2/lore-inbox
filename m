Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVBDWLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVBDWLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVBDWHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:07:04 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:52290 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264142AbVBDV4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:56:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ElsZO9CImidpa4tFlQGk2VFgaOYH3SqKKZuYRSRRfCI855IWaYo4Wg9fWaZJVuTv6UUGm+kszv5NEoMG0zoKoMvi90BGBgdpP4+ZrYN9bOWiU8SvOEPO+z67l7BtI0X/mCi6Ct+BfkDtr65yFkKQn9nztioNK8DyLTgQsovFpd8=
Message-ID: <d120d50005020413563d031866@mail.gmail.com>
Date: Fri, 4 Feb 2005 16:56:45 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] input: make some code static
Cc: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
       linux-input@atrey.karlin.mff.cuni.cz,
       linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050204213955.GE19408@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050204213955.GE19408@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005 22:39:55 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> This patch makes some needlessly global code static.
> 

Hi Adrian,

I merged your patch into my tree and it is ready for Vojtech to pull from.

-- 
Dmitry
