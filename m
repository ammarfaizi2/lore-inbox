Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262622AbTCIUyv>; Sun, 9 Mar 2003 15:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262623AbTCIUyv>; Sun, 9 Mar 2003 15:54:51 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:28312 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262622AbTCIUyu>; Sun, 9 Mar 2003 15:54:50 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Jason Straight <jason@JeetKuneDoMaster.net>
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Date: Sun, 9 Mar 2003 22:02:52 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303090144.11339.jason@JeetKuneDoMaster.net> <20030308225522.4e7301ea.akpm@digeo.com> <200303090916.44475.jason@JeetKuneDoMaster.net>
In-Reply-To: <200303090916.44475.jason@JeetKuneDoMaster.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303092202.52540.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I put it in the config but it gets removed by checkconfig.pl when I make,
> so I'm guessing there's more missing than just the line in the config. :-/

Don't compile the input layer as a module.

Duncan.

