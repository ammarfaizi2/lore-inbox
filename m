Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVEJSwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEJSwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVEJSwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:52:05 -0400
Received: from fmr19.intel.com ([134.134.136.18]:6569 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261739AbVEJSvz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:51:55 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/4] rt_mutex: add new plist implementation 
Date: Tue, 10 May 2005 11:51:33 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0338B681@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/4] rt_mutex: add new plist implementation 
Thread-Index: AcVVkPafJcE8/hvkSP62KmKh6Ws6CwAAD3Vw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <Valdis.Kletnieks@vt.edu>
Cc: "Oleg Nesterov" <oleg@tv-sign.ru>, "Ingo Molnar" <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 10 May 2005 18:51:35.0185 (UTC) FILETIME=[4A1B5010:01C55591]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Valdis.Kletnieks@vt.edu [mailto:Valdis.Kletnieks@vt.edu]
>On Tue, 10 May 2005 11:39:45 PDT, "Perez-Gonzalez, Inaky" said:
>
>> >I am not sure I understand you. Why should we track ->prio=20
changes?
>> >plist should be generic, I think.
>>
>> Errr....shut, that was my or your email program screwing
>> things up...that =20, I mean, that's MIME for line break.
>
>Actually, it's the MIME encoding for "blank".  It's usually seen with
trailing
>blanks, so systems that trim trailing blanks won't molest the one you
left on
>the end of the line.....

Tomatoe, tomato :)

Thanks,

-- Inaky
