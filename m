Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270478AbTGPIpm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 04:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270487AbTGPIpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 04:45:42 -0400
Received: from gandalf.avalon.ru ([195.209.229.227]:44715 "EHLO smtp.avalon.ru")
	by vger.kernel.org with ESMTP id S270478AbTGPIn5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 04:43:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Partitioned loop device..
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Wed, 16 Jul 2003 12:59:43 +0400
Message-ID: <E1B7C89B8DCB084C809A22D7FEB90B3840AE@frodo.avalon.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Partitioned loop device..
Thread-Index: AcNLFqtdn4SSHbleShSHsTvLDZ7TAQAXTZ7A
From: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
To: "Lars Marowsky-Bree" <lmb@suse.de>, "Kevin Corry" <kevcorry@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no difference. What makes /dev/loop1a worse than 
> /dev/hda1? It's just block devices, that's it.
Yes, it is. But I meant its still impossible to use legacy fdisk to
create that DM mapped partitions (or am I wrong?)

> I have hopes that the entire partitioning code etc will be 
> ripped out in 2.7 in favour of full userspace discovery + DM, 
> and that MD will hit the same fate...
MD - did you mean metadisks (software raids?)

Dimitry.
