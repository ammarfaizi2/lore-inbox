Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVINUZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVINUZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVINUZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:25:24 -0400
Received: from mail2.mail.iol.ie ([193.95.141.54]:60815 "EHLO
	mail2.mail.iol.ie") by vger.kernel.org with ESMTP id S932492AbVINUZX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:25:23 -0400
From: Martin Vlk <vlcakm@tiscali.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: The BogoMIPS value sometimes too low on Intel Mobile P3
Date: Wed, 14 Sep 2005 21:28:00 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509142128.01817.vlcakm@tiscali.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please try it with a more recent kernel, there have been some patches 
> which take into consideration SMIs occuring during the calibration
> loop. 

I have now been running 2.6.13.1 for some time and it looks really promising. 
The BogoMIPS value is now very "stable", i.e. not changing greatly from boot 
to boot.
I will report back if this hope happens to fail, but let it not be the case.

Thank you all for advice.
vlcak
