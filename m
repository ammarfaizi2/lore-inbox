Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbTAOSOE>; Wed, 15 Jan 2003 13:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266796AbTAOSOE>; Wed, 15 Jan 2003 13:14:04 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:48834 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S266615AbTAOSOD>; Wed, 15 Jan 2003 13:14:03 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACA85@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'DervishD'" <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: argv0 revisited...
Date: Wed, 15 Jan 2003 10:22:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     How can I know, more or less portably, which is the name of the
> disk binary corresponding to my core image? Since 'proc' is not
> mounted at this time, I cannot consult my mappings not my 'exe'
> link. Since this init is run as root, any that root can do is
> welcome. Although I would like a portable solution, any solution that
> works under *any* Linux kernel is welcome...

What about mounting /proc from inside your program? Not a big deal, easy
sollution ... 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

