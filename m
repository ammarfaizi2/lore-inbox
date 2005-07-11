Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVGKWpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVGKWpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVGKWow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:44:52 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3081 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262139AbVGKWnb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:43:31 -0400
Date: Tue, 12 Jul 2005 00:44:14 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Cc: mmazur@kernel.pl
Subject: Re: Kernel header policy
Message-ID: <20050711224414.GB25973@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org, mmazur@kernel.pl
References: <Pine.BSO.4.61.0507111533340.23021@login3.srv.ualberta.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.BSO.4.61.0507111533340.23021@login3.srv.ualberta.ca>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 03:37:47PM -0600, Marc Aurele La France wrote:
> I am contacting you to express my concern over a growing trend in kernel
> development.  I am specifically referring to changes being made to kernel
> headers that break compatibility at the userland level, where __KERNEL__
> isn't #define'd.

 You should CC person which maintains userspace kernel headers. I've
added Mariusz to CC list.

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

