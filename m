Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265084AbTFRHqk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 03:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265085AbTFRHqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 03:46:40 -0400
Received: from smtp.pentapharm.com ([194.209.245.131]:9991 "HELO
	fire0002.pentapharm.com") by vger.kernel.org with SMTP
	id S265084AbTFRHqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 03:46:39 -0400
MIME-Version: 1.0
Subject: AW: Kernel 2.5.71 cannot unmount nfs
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
Date: Wed, 18 Jun 2003 09:59:48 +0200
Message-ID: <0557B834CB410E4EB692BC78504D4C2C02F3F4@dc0011.pefade.pefa.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.5.71 cannot unmount nfs
Thread-Index: AcMz4+/TIlSbqsyGSAurmhkwXxoyAgBi3xUQ
From: "Seifert Guido, gse" <Guido.Seifert@pentapharm.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Jun 2003 07:59:49.0916 (UTC) FILETIME=[97B1CDC0:01C3356F]
Content-Type: multipart/mixed; boundary="----=_NextPartTM-000-63a556b7-ad1b-4ff7-9606-136905e1fe51"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format

------=_NextPartTM-000-63a556b7-ad1b-4ff7-9606-136905e1fe51
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Seifert Guido, gse, Mon, Jun 16, 2003 10:22:08 +0200:
>> Sorry for the incomplete and unprofessional bugreport, I don't have=20
>> more info. I tried Kernel 2.5.71. Everything seems to work fine until

>> I shut down or try to unmount a mountend nfs filesystem. For several=20
>> minutes nothing happens, then I get something what looks like a=20
>> backtrace from the nfs related code section. Unfortunately there is=20
>> nothing in the log files afterwards.

>See the patch at http://bugme.osdl.org/show_bug.cgi?id=3D805

Works great. Thank you.

G.



------=_NextPartTM-000-63a556b7-ad1b-4ff7-9606-136905e1fe51
Content-Type: text/plain;
	name="InterScan_SafeStamp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_SafeStamp.txt"

****** Message from InterScan E-Mail VirusWall NT ******

** No virus found in attached file noname.htm

E-mail is virus checked, Pentapharm Group, Switzerland, Support@pentapharm.com
*****************     End of message     ***************


------=_NextPartTM-000-63a556b7-ad1b-4ff7-9606-136905e1fe51--

------=_NextPartTM-000-63a556b7-ad1b-4ff7-9606-136905e1fe51--
