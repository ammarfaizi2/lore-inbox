Return-Path: <linux-kernel-owner+w=401wt.eu-S1751678AbXAPWAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbXAPWAn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 17:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbXAPWAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 17:00:43 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:4542 "EHLO
	HQEMGATE01.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbXAPWAm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 17:00:42 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jan 2007 17:00:42 EST
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Date: Tue, 16 Jan 2007 13:54:31 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B00E48D54B@hqemmail02.nvidia.com>
In-Reply-To: <20070116203143.GA4213@tuatara.stupidest.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
thread-index: Acc5rufLv1abkCjTT0eplUoc7NIjxwACYHzQ
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net> <45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net> <45ACE07D.3050207@shaw.ca> <20070116180154.GA1335@tuatara.stupidest.org> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org>
From: "Allen Martin" <AMartin@nvidia.com>
To: "Chris Wedgwood" <cw@f00f.org>,
       "Christoph Anton Mitterer" <calestyo@scientia.net>
Cc: "Robert Hancock" <hancockr@shaw.ca>, <linux-kernel@vger.kernel.org>,
       <knweiss@gmx.de>, <ak@suse.de>, <andersen@codepoet.org>,
       <krader@us.ibm.com>, "Lonni Friedman" <lfriedman@nvidia.com>,
       "Linux-Nforce-Bugs" <Linux-Nforce-Bugs@nvidia.com>
X-OriginalArrivalTime: 16 Jan 2007 21:54:28.0841 (UTC) FILETIME=[E5605590:01C739B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like to here from Andi how he feels about this?  It seems like a
> somewhat drastic solution in some ways given a lot of hardware doesn't
> seem to be affected (or maybe in those cases it's just really hard to
> hit, I don't know).
> 
> > Well we can hope that Nvidia will find out more (though I'm not too
> > optimistic).
> 
> Ideally someone from AMD needs to look into this, if some mainboards
> really never see this problem, then why is that?  Is there errata that
> some BIOS/mainboard vendors are dealing with that others are not?

NVIDIA and AMD are ivestigating this issue, we don't know what the
problem is yet.
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
