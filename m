Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQLLANE>; Mon, 11 Dec 2000 19:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbQLLAMz>; Mon, 11 Dec 2000 19:12:55 -0500
Received: from [200.222.195.150] ([200.222.195.150]:15108 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129906AbQLLAMt>; Mon, 11 Dec 2000 19:12:49 -0500
Date: Mon, 11 Dec 2000 21:42:14 -0200
From: Frédéric L . W . Meunier 
	<0@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: warning during make modules
Message-ID: <20001211214214.B1245@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Mailer: Mutt/1.2.5i - Linux 2.2.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a 2.4.0 issue? Because I see the warnings on 2.2.18
too, and also building alsa-driver. I use modutils 2.3.22.
binutils 2.10.1.0.2. glibc 2.2.

2.2.17 reported the same, 2.4.0-test11 too (but I never ran
this one).

The compiler is egcs 1.1.2. gcc is a symlink to egcs-2.1.96.

-- 
0@pervalidus.{net,{dyndns.}org} TelFax: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
