Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTKRN4p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTKRNyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:54:07 -0500
Received: from [193.41.178.97] ([193.41.178.97]:7032 "EHLO secemail")
	by vger.kernel.org with ESMTP id S262603AbTKRNwM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:52:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: 2.6.0-test9-mm3 and enanched IDE mode on p4c800 deluxe 
Date: Tue, 18 Nov 2003 14:52:31 +0100
Message-ID: <9E8BE1B970A998468D92381A112AA3EA0140E9@srvrm001.roma.seceti.it>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test9-mm3 and enanched IDE mode on p4c800 deluxe 
Thread-Index: AcOt2zX48AGg33M0RUeG40Q2YTI5Jw==
From: "Catani, Antonio" <Antonio.Catani@seceti.it>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Nov 2003 13:52:36.0671 (UTC) FILETIME=[39440CF0:01C3ADDB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi list, i can non know if my request is in topic or not.
I have p4c800 deluxe from asus, and works fine with mm3 patch, but I'v
notice a little beat strange thing in bios of this mobo there is a
option for setting ide interface in enanched mode, so if I set on the
kernel start and in dmesg I see ICH-5 100% native mode but after mount
root I get many of disabled irq 169 and the system hangs so to reset
hardware.

In compatible mode the system works fine, but I see in dmesg ICH-5 not
100% native mode, will probe irq later, someone can explain me the
difference about two behavior?

Many thanks



=== Start-of Internet E-mail Confidentiality Footer ===

L'uso non autorizzato di questo messaggio o dei suoi allegati e' vietato e potrebbe costituire reato.
Se ha ricevuto per errore questo messaggio, La preghiamo di informarci e di distruggerlo immediatamente coi suoi allegati.
Le dichiarazioni contenute in questo messaggio o nei suoi allegati non impegnano SECETI S.p.A. nei confronti del destinatario o di terzi.
SECETI S.p.A. non si assume alcuna responsabilita' per eventuali intercettazioni, modifiche o danneggiamenti del presente messaggio.
Any unauthorized use of this e-mail or any of its attachments is prohibited and could constitute an offence.
If you are not the intended addressee please advise immediately the sender and destroy the message and its attachments.
The contents of this message shall be understood as neither given nor endorsed by SECETI S.p.A.
SECETI S.p.A. does not accept liability for corruption, interception or amendment, if any, or the consequences thereof.
