Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTCJPyN>; Mon, 10 Mar 2003 10:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbTCJPyN>; Mon, 10 Mar 2003 10:54:13 -0500
Received: from 64-186-37-120.nmo.net ([64.186.37.120]:44673 "EHLO
	jkd.jeetkunedomaster.net") by vger.kernel.org with ESMTP
	id <S261338AbTCJPyM>; Mon, 10 Mar 2003 10:54:12 -0500
From: Jason Straight <jason@JeetKuneDoMaster.net>
To: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: 2.5.64bk3 no screen after Ok booting kernel
Date: Mon, 10 Mar 2003 11:04:51 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200303090144.11339.jason@JeetKuneDoMaster.net> <200303090916.44475.jason@JeetKuneDoMaster.net> <200303092202.52540.baldrick@wanadoo.fr>
In-Reply-To: <200303092202.52540.baldrick@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303101104.51020.jason@JeetKuneDoMaster.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 March 2003 04:02 pm, Duncan Sands wrote:
> > I put it in the config but it gets removed by checkconfig.pl when I make,
> > so I'm guessing there's more missing than just the line in the config.
> > :-/
>
> Don't compile the input layer as a module.
>
> Duncan.

Yeah, I got it. Thanks Andrew, Duncan, and Thomas.



-- 
Jason Straight
jason@JeetKuneDoMaster.net
icq: 1796276
pgp: http://www.JeetKuneDoMaster.net/~jason/pubkey.asc

