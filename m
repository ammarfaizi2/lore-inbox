Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUGPFcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUGPFcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 01:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266472AbUGPFcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 01:32:09 -0400
Received: from fmr05.intel.com ([134.134.136.6]:46265 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266460AbUGPFcF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 01:32:05 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Fri, 16 Jul 2004 13:31:55 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F03568506@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
Thread-Index: AcRpvwecpVm7wNvaSUml76reJOoH5wBNvjlg
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Robert W. Fuller" <kombi@sbcglobal.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jul 2004 05:31:56.0519 (UTC) FILETIME=[357E5F70:01C46AF6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please try 'nolapic' boot option. -Shaohua

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>owner@vger.kernel.org] On Behalf Of Robert W. Fuller
>Sent: Wednesday, July 14, 2004 11:58 PM
>To: linux-kernel@vger.kernel.org
>Subject: Re: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
>
>Hmm.  No reply.  Am I not asking for help in the right place?
>
>Robert W. Fuller wrote:
>> If I have ACPI configured for the 2.6.7 kernel, boot hangs after the
>> message "ACPI: IRQ9 SCI: Level Trigger."  If I configure the 2.6.7
>> kernel without ACPI, everything is fine.
>>
>> I would like to have ACPI because my laptop does not have APM.  The
>> laptop model is a Compaq Presario 2199US.
>> -
>> To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

