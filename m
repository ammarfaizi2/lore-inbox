Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264680AbUEaPsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264680AbUEaPsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 11:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbUEaPsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 11:48:06 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:47849
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S264680AbUEaPsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 11:48:04 -0400
Message-ID: <40BB53B2.3070101@freemail.hu>
Date: Mon, 31 May 2004 17:48:02 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MM patches (was Re: why swap at all?)
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.kerneltrap.org/~npiggin/nickvm-267r1m1.gz
> 
> It is a cocktail of cleanups, simplification, and enhancements. The
> main ones that applie here is my split active lists patch (search
> archives for details), and explicit use-once logic.

Works good, a vmware session (WinME on a simulated 128MB machine)
does not disturb two open mozillas for two different logged in users,
both using GNOME-2.4 on FC1 system.

Kernel is 2.6.7-rc1-mm1 + your patch + linuxconsole.sf.net ruby.
The machine used about 230KB swap. 512MB DRAM.

Best regards,
Zoltán Böszörményi


