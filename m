Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263413AbTJUVTc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTJUVTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:19:31 -0400
Received: from fluorine.one-2-one.net ([217.115.142.97]:19214 "EHLO
	fluorine.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263413AbTJUVTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:19:05 -0400
Message-ID: <007f01c39817$1ffadd70$fb457dc0@tgasterix>
From: "Thomas Giese" <thomas.giese@tgsoftware.de>
To: "James Simmons" <jsimmons@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310212141290.32738-100000@phoenix.infradead.org>
Subject: Re: 2.6.0-test8-mm1
Date: Tue, 21 Oct 2003 23:05:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this 2.6.0-mm1 is really very good,

but i would VERY enjoy to have the cloop-device from knopper in it!
we have the cryptloop, why not the very good cloop?

this would be a wonderful combination?

best Regards

Thomas Giese

-----Ursprüngliche Nachricht----- 
Von: "James Simmons" <jsimmons@infradead.org>
An: "Thomas Schlichter" <schlicht@uni-mannheim.de>
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>; "Andrew Morton"
<akpm@osdl.org>; <Valdis.Kletnieks@vt.edu>; <linux-kernel@vger.kernel.org>;
<linux-mm@kvack.org>
Gesendet: Dienstag, 21. Oktober 2003 22:42
Betreff: Re: 2.6.0-test8-mm1


>
> > > This patch was fine.  2.6.0-test8 with this patch booted and
> > > looked no different from plain 2.6.0-test8.  I am using it for
> > > writing this.  The problems must be in mm1 somehow.
> > >
> > > Helge Hafting
>
> Yeah!!!
>
> > Well here I've got same problems for -test8 + fbdev-patch as
with -test8-mm1.
> > I've compiled the kernel with most DEBUG_* options enabled (all but
> > DEBUG_INFO and KGDB) and see the same cursor and image corruption as
with
> > -mm1 and the same options enabled.
> >
> > Should I try compiling this kernel without the DEBUG_* options and watch
if I
> > get the invalidate_list Oops again?
>
> Yes. I'm using vesafb and I have no problems. I liek to see what the
> problem really is.
>
>

