Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVGFWwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVGFWwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVGFWua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:50:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27821 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262528AbVGFWuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:50:04 -0400
Message-ID: <42CC600A.1090506@namesys.com>
Date: Wed, 06 Jul 2005 15:49:46 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Hubert Chan <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a> <87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com> <42CBD7F6.2050203@slaphack.com> <42CC1DEE.7030502@namesys.com> <42CC4369.3070005@slaphack.com>
In-Reply-To: <42CC4369.3070005@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> So, will the format change happen at mount time?  Will it need a
> special mount flag?  Will I need to use debugfs or some other offline
> tool?


First we make sure we have the right answer.  Have we solved the cycle
problem?  Can we run out of memory as Horst/Nikita suggest?

