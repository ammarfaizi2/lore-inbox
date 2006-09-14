Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWINOiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWINOiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWINOiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:38:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:59777 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750868AbWINOip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:38:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=LzPyGwRWeDFhlAUwT88GccKVEMgMWG+Uahgsp4PYK/OzO/Q35W0u8zDsSYcMQrcgakvm67kgTvAzrpiWjdOjOtqPL6kH+YIeqVdDrsr/A9Qsdpb2bCUL/ac/+phojR4rn8gml6F/Vi+MdCYRQxq1uVh6OVCyHKUXkQewzgChVpk=
Message-ID: <4509697D.1050107@gmail.com>
Date: Thu, 14 Sep 2006 18:38:53 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: pm list <linux-pm@lists.osdl.org>
CC: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: PowerOP, Whatchanged/Issues/TODO 2/2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whatchanged:
- optional sysfs interface is added
- code is moved under kernel/power
- Greg's comments on kobject and coding style are addressed

todo/issues:
- better implementation for getting registered operating point names
- move string parsing into powerop generic code
- configfs for operating points creation from user space
- powerop driver module refcounting


