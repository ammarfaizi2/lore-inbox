Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263556AbTH0QxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTH0QxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:53:22 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:17562 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263556AbTH0QxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:53:21 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: herbert@13thfloor.at
Subject: Re: Reading accurate size of recepts from serial port
Date: Wed, 27 Aug 2003 18:53:18 +0200
User-Agent: KMail/1.5.2
Cc: Stuart MacDonald <stuartm@connecttech.com>,
       "'Russell King'" <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <005c01c36bdd$8ae58d30$294b82ce@stuartm> <200308261723.04683.laurent.huge@wanadoo.fr> <20030827145041.GC26817@www.13thfloor.at>
In-Reply-To: <20030827145041.GC26817@www.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308271853.18821.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mercredi 27 Août 2003 16:50, Herbert Pötzl a écrit :
> hmm, why not do simple framing ...
> [length]<data>[length]<data> ....
That's impossible. CCSDS is the committee for space date systems and it 
provides standards that I can't overrule (even if I can't really understand 
why they've done it like that !).
-- 
Laurent Hugé.

