Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUI1GRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUI1GRp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUI1GRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:17:45 -0400
Received: from fmr06.intel.com ([134.134.136.7]:1482 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267561AbUI1GRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:17:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Tue, 28 Sep 2004 14:16:59 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD57A3@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSlIkgrpDa5eCtvSLa2W8Szcb8qYQAACm+g
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Patrick Mochel" <mochel@digitalimplant.org>
Cc: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       <linux-kernel@vger.kernel.org>,
       "Denis Vlasenko" <vda@port.imtp.ilyichevsk.odessa.ua>,
       "Oliver Neukum" <oliver@neukum.org>
X-OriginalArrivalTime: 28 Sep 2004 06:17:00.0056 (UTC) FILETIME=[C37EE180:01C4A522]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> On Tue, 28 Sep 2004, Zhu, Yi wrote:
> 
>> Do you still think the ->save_state, ->restore_state are the right
>> approach
> 
> Yes.

Fine. That's the interface I mentioned last time. Sorry if it's
confusing.

Thanks,
-yi
