Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263231AbVGaOMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbVGaOMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 10:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVGaOKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 10:10:06 -0400
Received: from verein.lst.de ([213.95.11.210]:32920 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261806AbVGaOJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 10:09:47 -0400
Date: Sun, 31 Jul 2005 16:09:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Greg KH <gregkh@suse.de>
Cc: Markus Lidel <Markus.Lidel@shadowconnect.com>,
       Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: sysfs abuse in recent i2o changes
Message-ID: <20050731140939.GB25958@lst.de>
References: <20050628112102.GA1111@lst.de> <42C16691.3090205@shadowconnect.com> <20050628162125.GA9239@suse.de> <42C19214.6070708@shadowconnect.com> <20050628180719.GA11585@suse.de> <42C25CBF.8000509@shadowconnect.com> <20050708060028.GB5323@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708060028.GB5323@suse.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So folks, this is still in 2.6.13-rc4, shouldn't we pull it out so we
don't add an interface soon to be removed again to 2.6.13?
