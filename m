Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTI0CTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 22:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTI0CTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 22:19:04 -0400
Received: from fmr09.intel.com ([192.52.57.35]:36317 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262038AbTI0CTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 22:19:01 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3849D.B32B2DAF"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: ACPI patch flow
Date: Fri, 26 Sep 2003 22:18:54 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC871E@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI patch flow
Thread-Index: AcN32XGZ1Aau06qCTBOIM0wtQAeqsQMwQXjw
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <acpi-devel@lists.sourceforge.net>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@intel.com>
X-OriginalArrivalTime: 27 Sep 2003 02:18:58.0359 (UTC) FILETIME=[B5569C70:01C3849D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3849D.B32B2DAF
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: Jeff Garzik [mailto:jgarzik@pobox.com]=20
...
> I definitely support the posting of plain patches...

Done.

In addition to pushing to the bkbits.net acpi-test-* trees,
I'll publish a plain patch every time I commit a cset to acpi-test-*
tree.

Like we've traditionally done on sourceforge.net, I'll continue to
publish a cumulative plain patch every time the acpi-release-* tree is
updated,
but these will not live on sourceforge.net any more.

The folks at kernel.org have graciously volunteered the space.

Here's the plan:
http://kernel.org/pub/linux/kernel/people/lenb/acpi/patches/README.ACPI
And attached for the curious is my handy bk.checkin wrapper script.

Thank you for your continued patience and support.

-Len

------_=_NextPart_001_01C3849D.B32B2DAF
Content-Type: application/x-zip-compressed;
	name="bk.ZIP"
Content-Transfer-Encoding: base64
Content-Description: bk.ZIP
Content-Disposition: attachment;
	filename="bk.ZIP"

UEsDBBQAAAAIAO+xOi+Uf63kmAIAADMGAAAJAAAAYmsuY29tbWl0lVRNb5tAED1nf8UkYPlQwR56
a0VaYtPGiu1YtpM2jVKDYbFXhgXBurWi/vjOAjYfSaXUJ8/Me29nhpnRzumaC7r28i3RiAbrnekn
ccwl/s/2AsIsiSFjaQJZkihnGc3BAz9nEk0hPS642IAXRSC3DNz1DlImAvS5EPKI5cBFEVE6KLFh
gmWeZEok9aS/LV9RCKWJiBzpeeEo4zKBHcsEi8wk22CeQ3vpWG6AGvCu99CLe0HvujfpLVxCeAiP
cA5GACa94vKGsZRl8PRRqQlyxvxtAvE+l69Vd8YOWHjICbl35ovR7dRyNxiFn5UJE2/HVEXwB/y9
BMMIWMSxHSyz+tAHI3zvkpm9HFyPnXtnfGTXnjcJLO6uWvSj/Say8305tzvZN31vErlx5lNnPHfG
jr1wLL2imnpdiKkfs9Kb6qRob4sOesskZX9WX0ZjVF5OZqvhaE49P+WGbg9mo9XAXlViRptpBjwM
yezuSjEsmu7XNOJif6DlZNCUJWnEaMTEutCjxeiwnOKgSTJ0FsuCqFcK9EVe34aWm/4OXFJlZVEZ
p9TF1WDCixnoiGhV65rVE42hO5YET1CNHFS/eBfw7BRXU1Y06+Qg9dqob+NJUgIMAf2yZ1N74nyC
PsmYF0DtImRwO5k402WnqbraEkOvgaY8yFfb/xJZFNbArr7+sPTaNDfPVXazYj+n2J8P0BAogwO8
FUzIHEPNFBvME6nwl4H+oxqEJxzGyw7v1JBfvB2B/u3NqTMH0g3XxAtscnnBwHhoYS46Gv8Ekizu
qiOWHdIkQ6wsD9Zluy6iFQlIjmOEt2zzzNPj5cNVJFr1plYEWkwtysGImj78FHU9ud/Cg5r+z7GX
4zqb9cX8oB/Hv1Okohv/p0DIX1BLAQIUCxQAAAAIAO+xOi+Uf63kmAIAADMGAAAJAAAAAAAAAAEA
IAAAAAAAAABiay5jb21taXRQSwUGAAAAAAEAAQA3AAAAvwIAAAAA

------_=_NextPart_001_01C3849D.B32B2DAF--
