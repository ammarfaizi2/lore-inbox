Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292539AbSBZA1T>; Mon, 25 Feb 2002 19:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292546AbSBZA1J>; Mon, 25 Feb 2002 19:27:09 -0500
Received: from quechua.inka.de ([212.227.14.2]:44405 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S292539AbSBZA1C>;
	Mon, 25 Feb 2002 19:27:02 -0500
From: Bernd Eckenfels <ecki-news2002-02@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <02022518330103.01161@grumpersII>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16fVSQ-0002mO-00@sites.inka.de>
Date: Tue, 26 Feb 2002 01:27:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <02022518330103.01161@grumpersII> you wrote:
> But it only works if everything get linked with the new library.

Nope, just put the new Lib into /etc/ld.so.preload

Actually there is a unlink package out there, which does exactly this.

Greetings
Bernd
