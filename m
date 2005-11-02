Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbVKBHrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbVKBHrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVKBHrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:47:08 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:15799 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S932627AbVKBHrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:47:06 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Date: Wed, 2 Nov 2005 08:47:01 +0100
User-Agent: KMail/1.8.3
Cc: matthieu castet <castet.matthieu@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <4363F9B5.6010907@free.fr> <20051031155803.2e94069f.akpm@osdl.org> <436776C6.3040900@free.fr>
In-Reply-To: <436776C6.3040900@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511020847.01462.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > People get shouted at for adding /proc handlers.  Greg may have thoughts...
> > 
> Ok, we may be convert some values to sysfs. It would be nice if usbatm 
> allow us to export some common value (margin, ...).

Yes it would be nice.  Patches welcome :)

D.
