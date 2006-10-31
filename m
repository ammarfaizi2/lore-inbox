Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423777AbWJaSdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423777AbWJaSdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423776AbWJaSdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:33:22 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35087 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423773AbWJaSdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:33:20 -0500
Date: Tue, 31 Oct 2006 19:33:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061031183319.GR27968@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45477668.4070801@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:14:32AM -0800, Martin J. Bligh wrote:
>...
> PS. I still think -Werror is a good plan. But I acknowledge that's
> fairly extreme.

Note that this would imply options like -Wno-unused-function and
-Wno-unused-variable (unless you _really_ want to add a few thousand 
#ifdef's to the kernel).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

