Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVFRWaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVFRWaZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVFRWaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:30:25 -0400
Received: from quechua.inka.de ([193.197.184.2]:64937 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262173AbVFRWaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:30:21 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: A Great Idea (tm) about reimplementing NLS.
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20050616150419.GY23488@csclub.uwaterloo.ca>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DjlpT-0000Hk-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 19 Jun 2005 00:30:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20050616150419.GY23488@csclub.uwaterloo.ca> you wrote:
> As for filenames never being long enough, I don't think that is true.
> Filenames CAN be too long, but I don't see very many people think 250
> characters makes for a useful filename.  Most people seem happy with 50
> or so being a good limit even though many systems support much longer.
> 8 wasn't enough, and 25 or 30 was sometimes a bit short, but usually
> enough.  Not having enough filename length doesn't seem to be a problem
> in need of a solution on most systems anymore.

pathname length however is a bigger issue.  255bytes is pretty short,
especially if you distributed file systems with deeply nested mountpoints.

Greetings
Bernd
