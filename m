Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284205AbRLATcX>; Sat, 1 Dec 2001 14:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284207AbRLATcN>; Sat, 1 Dec 2001 14:32:13 -0500
Received: from mail305.mail.bellsouth.net ([205.152.58.165]:41496 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284205AbRLATb6>; Sat, 1 Dec 2001 14:31:58 -0500
Message-ID: <3C093029.EEF79D5A@mandrakesoft.com>
Date: Sat, 01 Dec 2001 14:31:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2 small patches against 2.4.17-pre2 (sym2 + email change)
In-Reply-To: <20011201165150.M1964-300000@gerard>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gérard Roudier wrote:
>         * version sym-2.1.17a
>         - Use u_long instead of U32 for the IO base cookie. This is more
>           consistent with what archs are expecting.

Well...  if you want to speak of style, no arch uses 'u_long'... rather
they use 'unsigned long' :)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

