Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVBWWpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVBWWpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVBWWpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:45:10 -0500
Received: from smtp06.auna.com ([62.81.186.16]:63876 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261648AbVBWWil convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:38:41 -0500
Date: Wed, 23 Feb 2005 22:38:40 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.11-rc4-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20050223014233.6710fd73.akpm@osdl.org>
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org> (from akpm@osdl.org on
	Wed Feb 23 10:42:33 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1109198320l.7018l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.23, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
> 
> 
> - Various fixes and updates all over the place.  Things seem to have slowed
>   down a bit.
> 
> - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
>   material, please tell me.
> 

Two points:

- I lost my keyboard :(. USB, but plugged into PS/2 with an adapter.
- hdb is missing. initscripts show an strange message about hdq ??
  As I read the same on other post, I think something has screwed the
  ide device naming scheme ...

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam10 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #2


