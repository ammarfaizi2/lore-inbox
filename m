Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTFDOy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFDOy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:54:27 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:65269 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S263354AbTFDOy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:54:26 -0400
Subject: Re: I2C/Sensors 2.5.70
From: Martin Schlemmer <azarah@gentoo.org>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20030604163948.00af3d28@pop.t-online.de>
References: <5.1.0.14.2.20030604163948.00af3d28@pop.t-online.de>
Content-Type: text/plain
Organization: 
Message-Id: <1054738541.5280.14.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 04 Jun 2003 16:55:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 16:51, Margit Schubert-While wrote:
> Is anybody looking at getting $Subject working ?
> At the moment i2c-sensor.c never gets compiled which is bad as
> it contains i2c_detect needed by all the sensors.

Will have to check with Greg here.

> And (assuming sensors works) where does the sensor info(fan, temp etc.)
> get put?
> 

In /sys/bus/i2c/....


Regards,

-- 
Martin Schlemmer


