Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTJXJe4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 05:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTJXJe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 05:34:56 -0400
Received: from [193.41.178.98] ([193.41.178.98]:62783 "HELO secemail")
	by vger.kernel.org with SMTP id S262115AbTJXJez convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 05:34:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: 2.6.0-test8-mm1
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Fri, 24 Oct 2003 11:35:12 +0200
Message-ID: <9E8BE1B970A998468D92381A112AA3EA0140E0@srvrm001.roma.seceti.it>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: 2.6.0-test8-mm1
Thread-Index: AcOaEh80JtXMLpGLQuGa+5lLoKpDag==
From: "Catani, Antonio" <Antonio.Catani@seceti.it>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Oct 2003 09:34:48.0936 (UTC) FILETIME=[11733E80:01C39A12]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list i'm trying use 2.6.0-test8-mm1 and it seems to be ok in my
machine, but I cant use radeonfb driver because my card dosent know by
the driver, I have a radeon 9600 pro triplex 128 mb , and lspci don't
know this card like radeonfb, so it's impossible for me test the
radeonfb driver.

Another tricks, is when use kde after two hours the machine freeze and
the only way to stop is or hardware reset or ALT+SysReq+O for the last
tricks I suspect cooling problem, tonight I try to downclok my cpu and
test.

I have also notice a downgrade of ide transfer rate from 2.6.0-mm6 to
2.6.0-test8-mm1 with the first kernel my hdparm -t was 1750 mb fo
second, now with 2.6.0-test8-mm1 is 1250 but the hdparm -T is the same
45 mb for second, I don't use libata patch 

I hope it help! 

Antonio Catani
Seceti S.p.A
tel 06-5470598
fax 06-5924010
cell 335-1255453 
e-mail antonio.catani@seceti.it 

