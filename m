Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269270AbTGOSQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269291AbTGOSQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:16:49 -0400
Received: from gandalf.avalon.ru ([195.209.229.227]:40251 "EHLO smtp.avalon.ru")
	by vger.kernel.org with ESMTP id S269270AbTGOSQa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:16:30 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Partitioned loop device..
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Tue, 15 Jul 2003 22:32:11 +0400
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3840AB@frodo.avalon.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Partitioned loop device..
Thread-Index: AcNK40qD45bUrwpqSkeeJoV6uaWu1QAGtyEQ
From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
To: "Kevin Corry" <kevcorry@us.ibm.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can already use Device-Mapper to create "partitions" on 
> your loop devices, 
You're right but I want _partitions_ but not "partitions" ;)
It should appears like a real hardware disk, not virtual one.

> so there's not much of a reason to add partitioning support 
> to the loop 
> driver itself.
There is a reason for teaching my students indeed :) that is why I ask.

> There are a variety of tools you can use to 
> set them up: EVMS, 
> LVM2, dmsetup, and I think there is/was a simple partitioning 
> tool that uses 
> DM (dmpartx?). 
It's just completely different topic for the teaching ;)
