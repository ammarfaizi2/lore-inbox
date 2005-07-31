Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVGaPcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVGaPcT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 11:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVGaPcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 11:32:19 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:60434 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S261789AbVGaPcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 11:32:18 -0400
Message-ID: <42ECF0ED.9070007@shadowconnect.com>
Date: Sun, 31 Jul 2005 17:40:29 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: sysfs abuse in recent i2o changes
References: <20050628112102.GA1111@lst.de> <42C16691.3090205@shadowconnect.com> <20050628162125.GA9239@suse.de> <42C19214.6070708@shadowconnect.com> <20050628180719.GA11585@suse.de> <42C25CBF.8000509@shadowconnect.com> <20050708060028.GB5323@suse.de> <20050731140939.GB25958@lst.de>
In-Reply-To: <20050731140939.GB25958@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Christoph Hellwig wrote:
> So folks, this is still in 2.6.13-rc4, shouldn't we pull it out so we

Yep, sorry... I'll try to send the patch during next week...

> don't add an interface soon to be removed again to 2.6.13?

The interface will still be available, because IMHO it fits better then 
the old ioctl based one... But until the necessary functions for the 
interface are available, i'll provide a separate patch, which could be 
downloaded at the I2O website...

Sorry for my delay :-(



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
