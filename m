Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316430AbSGLNpc>; Fri, 12 Jul 2002 09:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSGLNpb>; Fri, 12 Jul 2002 09:45:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:39919 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316430AbSGLNpb>;
	Fri, 12 Jul 2002 09:45:31 -0400
Message-ID: <00d401c229ab$02aa8030$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Mark Mielke" <mark@mark.mielke.cc>
Cc: "Daniel Phillips" <phillips@arcor.de>,
       "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <20020711062832.GU1548@niksula.cs.hut.fi> <002601c228ab$86b235e0$1c6fa8c0@hyper> <E17SheA-0002Uh-00@starship> <000901c2296e$7cab2ed0$1c6fa8c0@hyper> <20020712092442.A26797@mark.mielke.cc>
Subject: Re: bzip2 support against 2.4.18
Date: Fri, 12 Jul 2002 15:49:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote on Friday, July 12, 2002 3:24 PM +0200:
> I would suggest keeping bzImage as the actual kernel name, and the
> compression format to be a CONFIG parameter. This leaves all the
> installation notes correct. As the executable is self-extracting,
> there is no need for the type to be specified outside of the image.

That's the point to have the discussion about a new name for *Image has to
end. I will code the kernel compression format as a CONFIG parameter in
future releases. I think that's the place where it belongs. So nobody has to
lern a new name and all are happy.

Over and out.

Have fun further on,

    - Christian


