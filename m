Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVFJFaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVFJFaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 01:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVFJFaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 01:30:10 -0400
Received: from femail.waymark.net ([206.176.148.84]:15589 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S262321AbVFJFaF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 01:30:05 -0400
Date: 10 Jun 2005 05:10:54 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: [ACPI] acpi_processor_set_power_policy
To: linux-kernel@vger.kernel.org
Message-ID: <f03fef.ca015b@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Kenneth Parrish wrote to All <=-

 KP> # readprofile -r ; sleep 1 ; readprofile -m /boot/System.map
 | sort -nr

 KP>     527 total                                      0.0003
 KP>     502 acpi_processor_set_power_policy            2.6989
[..]

readprofile reports acpi_processor_set_power_policy evidently only
because i used a System.map from an earlier compilation of the same
kernel version - not thinking it mattered.
sorry for the noise;  thanks to who e-mailed me.  :-)

--- MultiMail/Linux v0.46
