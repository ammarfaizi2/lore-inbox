Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318205AbSHZSuE>; Mon, 26 Aug 2002 14:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSHZSuE>; Mon, 26 Aug 2002 14:50:04 -0400
Received: from AMarseille-201-1-2-149.abo.wanadoo.fr ([193.253.217.149]:4464
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318205AbSHZSuD>; Mon, 26 Aug 2002 14:50:03 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Egger <degger@fhm.edu>
Cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4-ac2
Date: Mon, 26 Aug 2002 22:06:23 +0200
Message-Id: <20020826200623.1556@192.168.4.1>
In-Reply-To: <1030379037.17690.8.camel@sonja.de.interearth.com>
References: <1030379037.17690.8.camel@sonja.de.interearth.com>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What are your plans to visualise the gmac removal in the config?
>At the moment it's not exactly obvious that sungem will work
>in place for gmac.

Not too sure about that, though Tom Rini sent me a patch that
will "upgrade" an existing config, I may just merge that and
remove the visible option.

Ben.


