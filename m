Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263168AbVF3VQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263168AbVF3VQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 17:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVF3VPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 17:15:52 -0400
Received: from pop.gmx.de ([213.165.64.20]:35285 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261254AbVF3VJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 17:09:22 -0400
X-Authenticated: #20450766
Date: Thu, 30 Jun 2005 21:51:47 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: =?ISO-8859-1?Q?Gustavo_Guillermo_P=E9rez?= <gustavo@compunauta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] build just one driver
In-Reply-To: <9a874849050629122775d0542c@mail.gmail.com>
Message-ID: <Pine.LNX.4.60.0506302149500.8278@poirot.grange>
References: <200506282309.20296.gustavo@compunauta.com>
 <9a874849050629122775d0542c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-1149222367-1120161107=:8278"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-1149222367-1120161107=:8278
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 29 Jun 2005, Jesper Juhl wrote:

> On 6/29/05, Gustavo Guillermo P=E9rez <gustavo@compunauta.com> wrote:
> > How can I build just one driver without building everthing or removing =
the
> > others from the config.
>=20
> See "make help" :=20
>=20
> $ make help | grep "dir/"
>   dir/            - Build all files in dir and below
>   dir/file.[ois]  - Build specified target only

Unfortunately, one cannot do make dir/module.ko... Would it be too=20
difficult to add?

Thanks
Guennadi
---
Guennadi Liakhovetski

---1463811839-1149222367-1120161107=:8278--
