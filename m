Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWBAQRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWBAQRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 11:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWBAQRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 11:17:13 -0500
Received: from ns.firmix.at ([62.141.48.66]:43657 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964980AbWBAQRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 11:17:11 -0500
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
From: Bernd Petrovitsch <bernd@firmix.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jiri Slaby <xslaby@fi.muni.cz>, kavitha s <wellspringkavitha@yahoo.co.in>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	 <Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 01 Feb 2006 17:16:56 +0100
Message-Id: <1138810616.16643.30.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 17:14 +0100, Jan Engelhardt wrote:
[...]
> >change root=LABEL=/ to root=/dev/XXX. Vanilla doesn't support this...
> >
> is there a kernel patch that does allow it?

Yes, in RedHat's/Fedora's kernels since ages.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

