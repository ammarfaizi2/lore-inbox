Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287371AbSAGXUo>; Mon, 7 Jan 2002 18:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287372AbSAGXUe>; Mon, 7 Jan 2002 18:20:34 -0500
Received: from nile.gnat.com ([205.232.38.5]:63178 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287371AbSAGXUV>;
	Mon, 7 Jan 2002 18:20:21 -0500
From: dewar@gnat.com
To: Dautrevaux@microprocess.com, dewar@gnat.com, guerby@acm.org,
        mrs@windriver.com
Subject: RE: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020107232020.A3CE3F28F1@nile.gnat.com>
Date: Mon,  7 Jan 2002 18:20:20 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>That is just broken and wrong

According to the gcc docs right? certainly not according to the standard!

<<If you want/need the gcc doc to expound on this, write it up, and
we'll add it.
>>

I think we should add this, since this is the source of the rule, not the
standard (as far as I can  tell)
