Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVFZXnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVFZXnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 19:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVFZXnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 19:43:24 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:17854 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261666AbVFZXnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 19:43:07 -0400
Message-ID: <42BF3D8F.4060503@namesys.com>
Date: Sun, 26 Jun 2005 16:43:11 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>            <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com>
In-Reply-To: <42BF2DC4.8030901@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> Valdis.Kletnieks@vt.edu wrote:
>
> >On Sun, 26 Jun 2005 14:58:07 CDT, David Masover said:
>
>
> >>"Plugins" is a bad word.  This user's combination of plugins is most
> >>likely identical to other users', it's just which ones are enabled, and
> >>which aren't?  If they are all included, I assume they play nice.
>
>
> >Which ones are enabled. Exactly.

Reiser4 plugins are not per user, but per kernel.  They are compiled
in.  The model is intended to ease the development process, nothing
more.  Apologies if the naming suggests more.

Hans
