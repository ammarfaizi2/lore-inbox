Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263535AbTFPIJA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTFPIJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:09:00 -0400
Received: from smtp.pentapharm.com ([194.209.245.131]:50701 "HELO
	fire0002.pentapharm.com") by vger.kernel.org with SMTP
	id S263535AbTFPII7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:08:59 -0400
Subject: Kernel 2.5.71 cannot unmount nfs
MIME-Version: 1.0
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
Date: Mon, 16 Jun 2003 10:22:08 +0200
Message-ID: <0557B834CB410E4EB692BC78504D4C2C02F3EC@dc0011.pefade.pefa.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kernel 2.5.71 cannot unmount nfs
Thread-Index: AcMz3XvntEHOatreQBughOJyp2pKjgAArzNQ
From: "Seifert Guido, gse" <Guido.Seifert@pentapharm.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jun 2003 08:22:11.0341 (UTC) FILETIME=[626B83D0:01C333E0]
Content-Type: multipart/mixed; boundary="----=_NextPartTM-000-0a17a1e1-02c8-490b-9906-5690cd3a62f9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format

------=_NextPartTM-000-0a17a1e1-02c8-490b-9906-5690cd3a62f9
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Sorry for the incomplete and unprofessional bugreport, I don't have more
info.=20
I tried Kernel 2.5.71. Everything seems to work fine until I shut down
or try to=20
unmount a mountend nfs filesystem. For several minutes nothing happens,=20
then I get something what looks like a backtrace from the nfs related
code=20
section. Unfortunately there is nothing in the log files afterwards.=20
G.=20


------=_NextPartTM-000-0a17a1e1-02c8-490b-9906-5690cd3a62f9
Content-Type: text/plain;
	name="InterScan_SafeStamp.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_SafeStamp.txt"

****** Message from InterScan E-Mail VirusWall NT ******

** No virus found in attached file noname.htm

E-mail is virus checked, Pentapharm Group, Switzerland, Support@pentapharm.com
*****************     End of message     ***************


------=_NextPartTM-000-0a17a1e1-02c8-490b-9906-5690cd3a62f9--

------=_NextPartTM-000-0a17a1e1-02c8-490b-9906-5690cd3a62f9--
