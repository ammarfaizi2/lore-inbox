Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265173AbTFRMFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbTFRMFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:05:03 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:51843 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265173AbTFRMFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:05:00 -0400
Message-Id: <5.1.0.14.2.20030618141052.00af0b50@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 18 Jun 2003 14:18:51 +0200
To: Greg KH <greg@kroah.com>
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCH] More i2c driver changes for 2.5.70
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030616184202.GD25585@kroah.com>
References: <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de>
 <5.1.0.14.2.20030612120959.00aec370@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Seen: false
X-ID: bpBvncZ6geepwVIxzt0KsO5sVIXYVK5tjPSL-0E8jljQ+zd6S+mqw4@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lm85, adm1021 patches also apply cleanly to 2.5.72 :-)
Question to Greg, Philip :
Is there really a race conditon with the update function ?
If so, all sensors are incorrect (also in CVS lmsensors).
Comments ?

Is any thought being given to merging ACPI and sensors ?

Margit

