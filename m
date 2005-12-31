Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVLaTuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVLaTuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 14:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVLaTuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 14:50:11 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:12304 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932096AbVLaTuK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 14:50:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=g1p2GCGCKjgyiX4s/tA7zDJPci0uXsT1xxTSc8mkiRxGDIoJOYu6HHkuFSW9n40bh4xnVpSZaioaJetju8dNUGXAG/3WaHVpFYCOqunbCBjbYphi7YOcb1zChADz5HdU0BveplJNF8L7H8AnrzZXeoxVihw8dB9pENDBfrpkn2M=
Date: Sat, 31 Dec 2005 20:48:45 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: luca.risolia@studio.unibo.it, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, gregkh@suse.de
Subject: Re: Oops with w9968cf
Message-Id: <20051231204845.313ac4c9.diegocg@gmail.com>
In-Reply-To: <20051231143229.GI3811@stusta.de>
References: <20051212151820.5656ddd8.diegocg@gmail.com>
	<20051231143229.GI3811@stusta.de>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 31 Dec 2005 15:32:29 +0100,
Adrian Bunk <bunk@stusta.de> escribió:


> Hi Diego,
> 
> thanks for your report.
> 
> Is this issue still present in kernel 2.6.15-rc7?
> Which was the last working kernel?

I've found it's not easily reproducible - I tried to reproduce
again and I couldn't. I've not used my webcam a lot and it's
easy to use it without getting oopses so I have no idea of
since when this bug has been there. I though it was a 
w9968 - which is why I CC'ed luca risolia (the maintainer)

I'll try to reproduce it again.
