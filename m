Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266696AbUF3PYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266696AbUF3PYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUF3PYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:24:24 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:12165 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S266696AbUF3PYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:24:20 -0400
X-OB-Received: from unknown (205.158.62.81)
  by wfilter.us4.outblaze.com; 30 Jun 2004 15:22:56 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: twl@mail.com
To: linux-kernel@vger.kernel.org
Date: Wed, 30 Jun 2004 10:25:18 -0500
Subject: Re: 2.6.7 oops in psmouse/serio while booting
X-Originating-Ip: 170.215.192.144
X-Originating-Server: ws1-2.us4.outblaze.com
Message-Id: <20040630152519.2DAB21F4FEA@ws1-2.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, 
>  
> Could you please try the patch below?  
>  
> --  
> Dmitry 
>  
 
Dmitry, 
 
Thanks for the quick response.  That fixed it. 
 
FYI, I still get 
input: PS/2 XXX Mouse on isa0060/serio1 
I booted 10 times, and "XXX" was "Generic" 7 times and "Logitech" 3 times. 
But no more oops. :^) 
 
Tom 
 
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

