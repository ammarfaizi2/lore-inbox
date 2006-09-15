Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWIOKNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWIOKNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 06:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWIOKNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 06:13:08 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:362 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750862AbWIOKNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 06:13:05 -0400
Message-ID: <450A7C98.3060106@openvz.org>
Date: Fri, 15 Sep 2006 14:12:40 +0400
From: Kir Kolyshkin <kir@openvz.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: devel@openvz.org
CC: rohitseth@google.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Devel] Re: [Patch 01/05]- Containers: Documentation on using
 containers
References: <1158284314.5408.146.camel@galaxy.corp.google.com> <200609150815.19917.eike-kernel@sf-tec.de>
In-Reply-To: <200609150815.19917.eike-kernel@sf-tec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Please also give a short description what containers are for. From 
> what I read
> here I can only guess it's about gettings some statistics about a group of 
> tasks.
>   
Container is like FreeBSD Jail on steroids (and Jail is chroot() on 
steroids).

As a nice intro, I suggest you to read
 http://en.wikipedia.org/wiki/Operating-system_level_virtualization
 http://en.wikipedia.org/wiki/OpenVZ
