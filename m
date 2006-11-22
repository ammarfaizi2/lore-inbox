Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755314AbWKVQRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbWKVQRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 11:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbWKVQRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 11:17:21 -0500
Received: from mga01.intel.com ([192.55.52.88]:56892 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1755314AbWKVQRT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 11:17:19 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,448,1157353200"; 
   d="scan'208"; a="167826744:sNHT21300363"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
Date: Wed, 22 Nov 2006 08:17:17 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07A5A41E@orsmsx420.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel ICH9
Thread-Index: AccOQdC7wUIaxlImStm2ctN7k3CZUAAD4dfA
From: "Gaston, Jason D" <jason.d.gaston@intel.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Cc: <jgarzik@pobox.com>, <linux-ide@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Nov 2006 16:17:18.0564 (UTC) FILETIME=[AE78CA40:01C70E51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know the specifics of that discussion.  If you are asking about
using class code rather then a DID; that would work for ICH9.

Thanks,

Jason



>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Arjan van de Ven
>Sent: Wednesday, November 22, 2006 1:04 AM
>To: Gaston, Jason D
>Cc: jgarzik@pobox.com; linux-ide@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH 2.6.19-rc6] ahci: AHCI mode SATA patch for Intel
ICH9
>
>On Tue, 2006-11-21 at 14:51 -0800, Jason Gaston wrote:
>> This patch adds the Intel ICH9 AHCI controller DID's for SATA
support.
>>
>> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
>
>there was some discussion about a generic class match for ahci...
>would these devices be matched by that?
>
>
>--
>if you want to mail me at work (you don't), use arjan (at)
linux.intel.com
>Test the interaction between Linux and your BIOS via
>http://www.linuxfirmwarekit.org
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
