Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbVINHoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbVINHoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVINHoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:44:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:649 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965065AbVINHoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:44:13 -0400
Date: Wed, 14 Sep 2005 09:44:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050914074448.GA14259@elte.hu>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru> <20050913185759.GA17272@mars.ravnborg.org> <20050913203720.GA12868@mipter.zuzino.mipt.ru> <20050914074248.GA21436@colo.lackof.org> <20050914074309.GA14116@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914074309.GA14116@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> git snapshots dont seem to be working right now, [...]

looked into the wrong place. You can get -git11 from:

 http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-git11.bz2

or -git12 (the latest Linus tree) from:

 http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.13-git12.bz2

	Ingo
