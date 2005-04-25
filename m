Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262728AbVDYSjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbVDYSjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVDYSjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:39:15 -0400
Received: from magic.adaptec.com ([216.52.22.17]:29644 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262702AbVDYSir convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:38:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/scsi/aacraid/: make some functions static
Date: Mon, 25 Apr 2005 14:38:41 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B0112D180@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/scsi/aacraid/: make some functions static
Thread-Index: AcVJw35C4cEWRGPrR5KG1gqBmVTZ0wAANbTA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Adrian Bunk" <bunk@stusta.de>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-)

Ah, but you misunderstand, there was no mind reading (nor is there any
ill will or serious admonition of the people or the process). I saw the
patch on the list by Adrian in November and applied it to my branch of
the aacraid driver in anticipation of its acceptance. This is a case of
the patch dropping on the floor and I am wondering where it got lost 'in
the system'.

Adrian did the right thing by resending it. However, resending it also
shows that the community was denied a patch for 5 months.

Maybe we should institute a procedure where the 'Signed-off-by' person
is privately mailed an ACK or NAK at each stage of acceptance of a patch
they authored? But that does not deal with patches that are dropped on
the floor though.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of James Bottomley
Sent: Monday, April 25, 2005 2:17 PM
To: Salyzyn, Mark
Cc: Adrian Bunk; SCSI Mailing List; Linux Kernel
Subject: RE: [2.6 patch] drivers/scsi/aacraid/: make some functions
static

On Mon, 2005-04-25 at 07:51 -0400, Salyzyn, Mark wrote:
> I approve, original was applied to Adaptec Branch on November 24th
2004.
> 
> Why is this one taking so long to propagate?

I'm sorry, owing to interference from the American Institute of
Parapsychology, the telepathic patch transmission service into the SCSI
tree has been discontinued.  The upshot is that if you apply a patch to
your tree, it doesn't actually appear in mine unless you actually send
it to the SCSI list and shepherd its progress.

James



-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
