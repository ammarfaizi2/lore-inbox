Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVGFXxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVGFXxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVGFUFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:39 -0400
Received: from main.gmane.org ([80.91.229.2]:44519 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261847AbVGFSQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:16:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <fieroch@web.de>
Subject: Re: Linux 2.6.13-rc2 Compile error in bt87x.c
Date: Wed, 06 Jul 2005 20:15:13 +0200
Message-ID: <dah73h$78g$1@sea.gmane.org>
References: <Pine.LNX.4.58.0507061342100.4612@gateway.bencastricum.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050611)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <Pine.LNX.4.58.0507061342100.4612@gateway.bencastricum.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Castricum wrote:
>   CC [M]  sound/pci/bt87x.o
> sound/pci/bt87x.c: In function `snd_bt87x_detect_card':
> sound/pci/bt87x.c:807: `driver' undeclared (first use in this function)
> sound/pci/bt87x.c:807: (Each undeclared identifier is reported only once
> sound/pci/bt87x.c:807: for each function it appears in.)
> sound/pci/bt87x.c: At top level:
> sound/pci/bt87x.c:910: `driver' used prior to declaration
> make[2]: *** [sound/pci/bt87x.o] Error 1
> make[1]: *** [sound/pci] Error 2

Hi,

there is a patch a few threads above (called "ALSA bt87x compile failure 
in 2.6.13-rc3").

Regards,
Alexander

