Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUALKgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUALKgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:36:51 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:25476 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S266097AbUALKgu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:36:50 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 10:36:48 +0000
User-Agent: KMail/1.5.4
References: <20040109014003.3d925e54.akpm@osdl.org> <3FFF79E5.5010401@winischhofer.net> <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401121036.48107.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 Jan 2004 2:58 am, Linus Torvalds wrote:
>
> I occasionally get huge drops from James, and they invariably break stuff.
> Which means that I often decide (espcially when trying to stabilize
> things) that I just can't _afford_ to apply the fr*gging patches. Because
> by past experience applying one of the big "everything changes" patches
> tends to break more things that it fixes.
>

I want the new fb stuff very badly.

My particular application is a game which has it's own software 3D renderer, 
so it just needs to be able to blast the frames into video ram. A good fbdev 
would mean not needing X, which would be nice.

Please consider this for inclusion in very early 2.7. And I urge James to work 
with Linus on this. Perhaps when it's stable in 2.7, we can back-port to 
2.6 :)

Andrew Walrond

