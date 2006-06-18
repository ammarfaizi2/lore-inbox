Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWFRVPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWFRVPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 17:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWFRVPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 17:15:09 -0400
Received: from quechua.inka.de ([193.197.184.2]:25301 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750784AbWFRVPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 17:15:07 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: problems with "different security models"
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <32124b660606181309o78bf2527s89a451c342e7fbe7@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Fs4bp-00073w-00@calista.eckenfels.net>
Date: Sun, 18 Jun 2006 23:15:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ojciec Rydzyk <69rydzyk69@gmail.com> wrote:
> -> Enable different security models". When this option is enabled, X
> starts but when I log in to kde or gnome, X restarts. There is no
> trace in any logs.

Well, I dont know what option that is, but it is a problem of your
distribution, not the kernel, most likely. If x restarts, that usually means
the session had terminated. For example it was missing rights to start the
session script. If you cant debug that little more specific, you might want
to let that option off? :)

Gruss
Bernd
