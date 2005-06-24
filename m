Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVFXAQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVFXAQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 20:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbVFXAQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 20:16:14 -0400
Received: from quechua.inka.de ([193.197.184.2]:27777 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262915AbVFXAQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 20:16:11 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <42BB4C81.6070500@namesys.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Dlbrd-0004QS-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 24 Jun 2005 02:16:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <42BB4C81.6070500@namesys.com> you wrote:
> reiser@linux:~/scratch> touch fufu
> reiser@linux:~/scratch> touch fifu
> reiser@linux:~/scratch> rm *fu fi*
> rm: cannot remove `fifu': No such file or directory

# echo rm *fu fi*
rm fifu fufu fifu

shell magic :)

Bernd
