Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTFDSmC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 14:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTFDSmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 14:42:02 -0400
Received: from a089003.adsl.hansenet.de ([213.191.89.3]:53677 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S261788AbTFDSmB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 14:42:01 -0400
Message-ID: <3EDE4049.8040205@portrix.net>
Date: Wed, 04 Jun 2003 20:54:01 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030521 Debian/1.3.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Margit Schubert-While <margitsw@t-online.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: I2C/Sensors 2.5.70
References: <5.1.0.14.2.20030604200930.00afde40@pop.t-online.de>
In-Reply-To: <5.1.0.14.2.20030604200930.00afde40@pop.t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look in -mm, Documentation/i2c/sysfs-interface.
Mainline seems to have lost this...
Greg KH is the Maintainer, though I wrote the via686a driver.

Jan


Margit Schubert-While wrote:
>  > Martin Schlemmer wrote :
>  > Will have to check with Greg here.
> OK - Has anybody tested/got running I2C/Sensors > 2.5.6x ?
> 
> Who's maintaining the 2.5 sensors part ?
> Need some info on naming conventions/display units for a port
> of lm85 driver (chips lm85(b,c), adm1027, adt7463).
> Doc is a wee bit out of date :-)
> 
> Margit
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


