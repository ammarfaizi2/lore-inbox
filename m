Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbVFXKS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbVFXKS4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbVFXKSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:18:55 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:17625 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S263231AbVFXKQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:16:35 -0400
Message-ID: <42BBC189.5050805@trex.wsi.edu.pl>
Date: Fri, 24 Jun 2005 10:17:13 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org, randy_dunlap <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Script to help users to report a BUG
References: <4d8e3fd30506191332264eb4ae@mail.gmail.com>	 <20050622120848.717e2fe2.rdunlap@xenotime.net>	 <42B9CFA1.6030702@trex.wsi.edu.pl>	 <20050622174744.75a07a7f.rdunlap@xenotime.net>	 <9a87484905062311246243774e@mail.gmail.com>	 <20050623120647.2a5783d1.rdunlap@xenotime.net>	 <9a87484905062312131e5f6b05@mail.gmail.com>	 <42BAF608.6080802@trex.wsi.edu.pl>	 <4d8e3fd305062313032c9789e8@mail.gmail.com>	 <42BAFE3E.2050407@trex.wsi.edu.pl> <4d8e3fd305062400524f0ad358@mail.gmail.com>
In-Reply-To: <4d8e3fd305062400524f0ad358@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the latest version:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/ort-a10.tar.bz2

Changelog:
- Paolo's text input method - txt_read() (old is txt_read_ed() it's only 
a test ;))
- now only root [uid=0] may run script
- small optimalisations (point 8 etc.)

Todo:
- more email clients
- bugzilla automatic posts?
- documentation

Regards,
Micha³ Piotrowski
