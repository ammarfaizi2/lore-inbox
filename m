Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbTDAIfm>; Tue, 1 Apr 2003 03:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTDAIfm>; Tue, 1 Apr 2003 03:35:42 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:5685
	"EHLO eumucln01.mscsoftware.com") by vger.kernel.org with ESMTP
	id <S262186AbTDAIfl>; Tue, 1 Apr 2003 03:35:41 -0500
Message-ID: <3E8951D0.5327C7FE@mscsoftware.com>
Date: Tue, 01 Apr 2003 10:46:08 +0200
From: Martin Knoblauch <"martin.knoblauch "@mscsoftware.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-ac1-mkn i686)
X-Accept-Language: en
MIME-Version: 1.0
To: gibbs@scsiguy.com
CC: linux-kernel@vger.kernel.org
Subject: Re: File system corruption under 2.4.21-pre5-ac1
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.19.0.3; VDF: 6.19.0.3
	 at mailmuc has not found any known virus in this email.
X-MIMETrack: Itemize by SMTP Server on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 04/01/2003 10:41:52 AM,
	Serialize by Router on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 04/01/2003 10:41:59 AM,
	Serialize complete at 04/01/2003 10:41:59 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: File system corruption under 2.4.21-pre5-ac1
> 
> From: Justin T. Gibbs (gibbs@scsiguy.com)
> Date: Mon Mar 31 2003 - 14:26:27 EST
> 
> 
> > I'm seeing filesystem corruption on a number of intel SE7501wv2's under
> > 2.4.21-pre5-ac1. The systems are running Cerberus (ctcs). They fail the
> > kcompile, and memtst tests.
> 
> Are you running the aic79xx driver version embedded in that kernel version
> or the latest from my site?
> 
> http://people.FreeBSD.org/~gibbs/linux/SRC/
> 
Justin,

 would you call the 1.3.6 version of aic79xx stable or "production
quality"? There still seems to be quite a lot of changes going on. 

Martin
