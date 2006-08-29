Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWH2Je6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWH2Je6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWH2Je6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:34:58 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52421 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964783AbWH2Je5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:34:57 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: pschroeder@uplogix.com
Subject: Re: [PATCH] Moschip 7840 USB-Serial Driver
Date: Tue, 29 Aug 2006 11:34:53 +0200
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "'TechSupport'" <techsupport@moschip.com>,
       AJN Rao <ajnrao@moschip.com>, AJN Rao <ajn@moschip.com>
References: <44F3ED45.7080502@uplogix.com>
In-Reply-To: <44F3ED45.7080502@uplogix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291134.54379.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 09:31, Paul B Schroeder wrote:
> Worked with the tech support folks at Moschip Semiconductor to get the driver 
> working on the latest kernel.  We've been using it for a bit now and it appears 
> to be working well.  They're okay with kernel inclusion of the driver.  I've 
> cleaned it up a bit and put this patch together.

On a slightly related topic, I've recently submitted a cleaned up version
of the driver for the moschip 7830 USB-ethernet chip. I included the only
address from Moschip that was known to me in all correspondence, but never
got any comment from them.

Is there anyone from moschip that is qualified to comment on my code,
or maybe even take over maintenance?

	Arnd <><
