Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSGANX2>; Mon, 1 Jul 2002 09:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315539AbSGANX1>; Mon, 1 Jul 2002 09:23:27 -0400
Received: from web20513.mail.yahoo.com ([216.136.174.44]:52259 "HELO
	web20513.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315529AbSGANX1>; Mon, 1 Jul 2002 09:23:27 -0400
Message-ID: <20020701132554.75863.qmail@web20513.mail.yahoo.com>
Date: Mon, 1 Jul 2002 15:25:54 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [ANNOUNCE] CMOV emulation for 2.4.19-rc1
To: vda@port.imtp.ilyichevsk.odessa.ua, Willy TARREAU <willy@w.ods.org>,
       willy@meta-x.org, linux-kernel@vger.kernel.org,
       Ronald.Wahl@informatik.tu-chemnitz.de
In-Reply-To: <200207011316.g61DGxT18808@Port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you code up a "dummy" emulator (which just
> ignores any invalid opcode by doing eip+=3) and
> compare trap times of your emulator and dummy
> one for, say, CMOVC AL,AL? (with carry flag
> cleared)

I may do this. Don't have the time at the moment,
but perhaps this evening...

cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
