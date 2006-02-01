Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWBAQTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWBAQTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWBAQTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:19:01 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14992 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964985AbWBAQTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:19:00 -0500
Date: Wed, 1 Feb 2006 17:18:56 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: Jiri Slaby <xslaby@fi.muni.cz>, kavitha s <wellspringkavitha@yahoo.co.in>,
       linux-kernel@vger.kernel.org
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
In-Reply-To: <1138810616.16643.30.camel@tara.firmix.at>
Message-ID: <Pine.LNX.4.61.0602011718450.22529@yvahk01.tjqt.qr>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz> 
 <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr> <1138810616.16643.30.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
>> >change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
>> >
>> is there a kernel patch that does allow it?
>
>Yes, in RedHat's/Fedora's kernels since ages.
>
Thanks, I'll see if it's of use to me.


Jan Engelhardt
-- 
