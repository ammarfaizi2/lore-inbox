Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbTFRPjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbTFRPjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:39:45 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:42933 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265284AbTFRPjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:39:44 -0400
Message-Id: <5.1.0.14.2.20030618173956.00aa4090@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 18 Jun 2003 17:53:18 +0200
To: Greg KH <greg@kroah.com>
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030618142206.GA16055@kroah.com>
References: <5.1.0.14.2.20030618141052.00af0b50@pop.t-online.de>
 <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de>
 <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de>
 <5.1.0.14.2.20030618141052.00af0b50@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: Gt0i7cZO8e-xza4l3W7OWTvb6Sn+SjlyFi5KLB+s9YSchXsDSAETcR@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>Yes, I have them in a bk tree and will be sending them to Linus later

         Super, then I can take the heat from Philip from  not including his
         latest patches.

>Where do o you think the race is?

         I have no idea.. Ask Philip, Either we have a problem or not.
         I am just trying to conform.


> > If so, all sensors are incorrect (also in CVS lmsensors).
> > Comments ?

         Nothing here ?

> >
> > Is any thought being given to merging ACPI and sensors ?
>
>The way we report the sensor values to userspace, yes, I have talked
>with the acpi people about this in the past.  But it looks like a 2.7
>thing at the earliest.

         Super, at least something.

>thanks,
>
>greg k-h

