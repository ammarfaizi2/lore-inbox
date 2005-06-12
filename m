Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVFLTau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVFLTau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVFLTaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:30:06 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:27661 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261151AbVFLTQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 15:16:24 -0400
Date: Sun, 12 Jun 2005 21:17:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Ilan S." <ilan_sk@netvision.net.il>, linux-kernel@vger.kernel.org
Subject: Re: 'hello world' module
Message-ID: <20050612191737.GA8215@mars.ravnborg.org>
References: <200506111511.02581.ilan_sk@netvision.net.il> <20050611181753.GA17310@mars.ravnborg.org> <Pine.LNX.4.61.0506112225040.2372@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506112225040.2372@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 10:25:30PM +0200, Jan Engelhardt wrote:
> 
> >> [ilanso@Netvision Kernel]$ make -C /home/ilanso/src/linux-2.6.11.11 M=`pwd`
> 
> Try adding "modules" at the end?

In 2.6 thats implicit when using M=... syntax.

	Sam
