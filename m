Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWGKIDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWGKIDt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 04:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWGKIDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 04:03:48 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:55968 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750723AbWGKIDr
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 11 Jul 2006 04:03:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17587.23103.199944.351666@gargle.gargle.HOWL>
Date: Tue, 11 Jul 2006 11:58:55 +0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 6/9] -Wshadow: 'map_bh' and 'wbc' shadow fixes
Newsgroups: gmane.linux.kernel
In-Reply-To: <200607101313.08607.jesper.juhl@gmail.com>
References: <200607101313.08607.jesper.juhl@gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000010 62f0209d0f0b003650422281e6684af9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl writes:
 > (please see the mail titled 
 >  "[RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow"
 >  for an explanation of why I'm doing this)
 > 
 > 
 > Fixes for the following -Wshadow warnings :
 > 

[...]

 >   fs/mpage.c:706: warning: declaration of 'wbc' shadows a parameter
 >   fs/mpage.c:699: warning: shadowed declaration is here

That chunk seems to be missing from the patch.

Nikita.

