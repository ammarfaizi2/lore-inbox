Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030786AbVKIV7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030786AbVKIV7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030787AbVKIV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:59:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50181 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030786AbVKIV7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:59:41 -0500
Date: Wed, 9 Nov 2005 22:59:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: Gerd Knorr <kraxel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make vesafb build without CONFIG_MTRR
Message-ID: <20051109215934.GD4047@stusta.de>
References: <436F5C5A.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436F5C5A.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:53:30PM +0100, Jan Beulich wrote:

> vesafb did not build without CONFIG_MTRR.
>...

I wasn't able to reproduce your problem.

Please send the error message and the a complete .config for reproducing 
it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

