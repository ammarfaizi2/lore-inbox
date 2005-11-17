Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVKQTtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVKQTtc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVKQTtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:49:32 -0500
Received: from 90.Red-213-97-199.staticIP.rima-tde.net ([213.97.199.90]:13151
	"HELO fargo") by vger.kernel.org with SMTP id S964825AbVKQTtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:49:31 -0500
Date: Thu, 17 Nov 2005 20:49:18 +0100
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@stusta.de>, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: /net/sched/Kconfig broken
Message-ID: <20051117194918.GB12121@fargo>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Adrian Bunk <bunk@stusta.de>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20051116194414.GA14953@fargo> <20051116.115141.33136176.davem@davemloft.net> <20051116201020.GA15113@fargo> <20051116231650.GR5735@stusta.de> <20051117135731.GA11238@fargo> <Pine.LNX.4.61.0511171643430.1610@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0511171643430.1610@scrub.home>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Nov 17 at 04:51:51, Roman Zippel wrote:
> No, they were there before too, but you have to go up one level to see 
> them.

I see them know. It was dificcult to find them...

> It's better in 2.6.15-rc1-git5, but the menu structure is still a little 
> messed up, the patch below properly indents all menu entries.

Thanks for the patch, i'll apply it.

regards,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
