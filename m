Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272073AbTGYNzJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 09:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272074AbTGYNzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 09:55:09 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:38061 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272073AbTGYNzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 09:55:06 -0400
Date: Fri, 25 Jul 2003 16:10:13 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Bernd Eckenfels <ecki-lkm@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: why the current kernel config menu layout is a mess
Message-ID: <20030725141013.GC29152@louise.pinerecords.com>
References: <E19frN3-00025I-00@calista.inka.de> <Pine.LNX.4.53.0307250820320.25867@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307250820320.25867@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rpjday@mindspring.com]
> 
>   some time ago, i suggested it would be nice to be able to deselect
> entire submenus right at the top level.  for example, it's clearly
> inefficient to have to select "Parallel port support" and bring
> up its corresponding submenu, if your only goal is to *deselect*
> that option.

Now that the menuconfig command extension to Kconfig has been merged,
I guess I could look into fixing the worst offenders.

-- 
Tomas Szepe <szepe@pinerecords.com>
