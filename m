Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287341AbSAGXMe>; Mon, 7 Jan 2002 18:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSAGXMZ>; Mon, 7 Jan 2002 18:12:25 -0500
Received: from nile.gnat.com ([205.232.38.5]:48842 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287342AbSAGXMS>;
	Mon, 7 Jan 2002 18:12:18 -0500
From: dewar@gnat.com
To: jtv@xs4all.nl, tim@hollebeek.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020107231218.1F5D5F2DC3@nile.gnat.com>
Date: Mon,  7 Jan 2002 18:12:18 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Is there really language in the Standard preventing the compiler from
constant-folding this code to "int a = 13;"?
>>

If there is no such language (I do not have my copy with me)< then the
standard is most certainly broken :-)
