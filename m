Return-Path: <linux-kernel-owner+w=401wt.eu-S932155AbXACWNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbXACWNe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbXACWNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:13:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4901 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932147AbXACWNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:13:33 -0500
Date: Wed, 3 Jan 2007 21:13:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Remove fastcall references in x86_64 code.
Message-ID: <20070103201334.GI20714@stusta.de>
References: <20070102210930.GA15354@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102210930.GA15354@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 07:09:30PM -0200, Glauber de Oliveira Costa wrote:

> Unlike x86, x86_64 already passes arguments in registers.
>...

Nitpick:
In 2.6.20-rc:  s/x86/UML on x86/

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

