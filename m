Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275082AbTHLG2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275085AbTHLG2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:28:37 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:62726 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S275082AbTHLG2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:28:35 -0400
Date: Tue, 12 Aug 2003 08:28:32 +0200
To: "Mark W. Alexander" <slash@dotnetslash.net>
Cc: Herbert =?iso-8859-15?Q?P=F6tzl?= <herbert@13thfloor.at>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030812062832.GA9608@gamma.logic.tuwien.ac.at>
References: <20030811222134.GA10481@www.13thfloor.at> <Pine.LNX.4.44.0308112148110.20222-100000@llave.eproinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0308112148110.20222-100000@llave.eproinet.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Mark W. Alexander wrote:
> > > VFS: cannot mount ...
> 
> Are you using an initrd image and if so, are you using the new

No, but to be on the sure side I rebuild a kernel with
	CONFIG_INITRD is not set
and got the same effect.

I think I give up. Hundreds of Alt-PrintScr-b are disturbing ;-)

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
DUDOO (n.)
The most deformed potato in any given collection of potatoes.
			--- Douglas Adams, The Meaning of Liff
