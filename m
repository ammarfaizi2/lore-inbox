Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWCNMxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWCNMxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCNMxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:53:12 -0500
Received: from spirit.analogic.com ([204.178.40.4]:27409 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1751270AbWCNMxK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:53:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
in-reply-to: <4416ABB1.8020802@samwel.tk>
x-originalarrivaltime: 14 Mar 2006 12:52:45.0177 (UTC) FILETIME=[3073CE90:01C64766]
Content-class: urn:content-classes:message
Subject: Re: Router stops routing after changing MAC Address
Date: Tue, 14 Mar 2006 07:52:38 -0500
Message-ID: <Pine.LNX.4.61.0603140740040.8187@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZHZjB9yiczdsUbRiak9CXAdmXMSQ==
References: <925A849792280C4E80C5461017A4B8A20321F9@mail733.InfraSupportEtc.com> <Pine.LNX.4.61.0603131730100.5785@chaos.analogic.com> <4416ABB1.8020802@samwel.tk>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Bart Samwel" <bart@samwel.tk>
Cc: "Greg Scott" <GregScott@InfraSupportEtc.com>,
       "Rick Jones" <rick.jones2@hp.com>,
       "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Mar 2006, Bart Samwel wrote:

> linux-os (Dick Johnson) wrote:
>> On Mon, 13 Mar 2006, Greg Scott wrote:
>> Bzzzzst... Not! There are not any MAC addresses associated with any
>> of the intercity links, usually not even in WANs!  MAC is for
>> Ethernet! Once you go to fiber, ATM, T-N, etc., there are no MAC addresses.
>
> Bzzzzt. According to WikiPedia:
>
> http://en.wikipedia.org/wiki/MAC_address
>
> MAC addresses are used for:
>
> - Token ring
> - 802.11 wireless networks
> - Bluetooth
> - FDDI
> - ATM (switched virtual connections only, as part of an NSAP address)
> - SCSI and Fibre Channel (as part of a World Wide Name)
>
> FDDI = fiber, ATM = ATM.
>
> --Bart
>

A name is NOT.  I can call my mail route number RFD#2 a MAC
address. Also token-ring is a form of Ethernet as are all
known wireless networks unless they use light. Even cable
modems use Ethernet, with FDM on the cable side and baseband
on the customer side. Calling SCSI MAC is absurd. All of the
above, except the ethernets are forms of point-to-point
communications links. IP (over/under or through) these
links uses a source and destination IP and any hardware
addressing scheme is incidental.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
