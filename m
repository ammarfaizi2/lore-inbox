Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbTH2QlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 12:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTH2QlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 12:41:14 -0400
Received: from PAT.cpr.ca ([209.115.235.79]:58675 "HELO calcprsmtp01.cpr.ca")
	by vger.kernel.org with SMTP id S261415AbTH2QlG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 12:41:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
Subject: RE: Related Problems? [WAS: 2.6.0-test4: Unable to handle kernel NULL pointer dereference]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 29 Aug 2003 10:41:04 -0600
Message-ID: <68D2A80760018245B05351CDCACF543601DFDA@CALGARYMAIL04.cpr.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
Thread-Index: AcNt1ppXa3COR4KrSlyRGZH7H+tnlwAXlH/AAAXVhtA=
From: "Garrett Serack" <Garrett_Serack@cpr.ca>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Aug 2003 16:41:04.0689 (UTC) FILETIME=[56A77210:01C36E4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My guess now is that they are not completely related, the fdisk one I think is fixed by 2.6.0-test4-mm-3, and the other two are not, but may be fixed by the other patch (~disable-athlon-prefetch) that was posted.

hmmm

G

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Garrett Serack
Sent: Friday, August 29, 2003 8:01 AM
To: linux-kernel@vger.kernel.org
Subject: Related Problems? [WAS: 2.6.0-test4: Unable to handle kernel
NULL pointer dereference]


I'm experiencing all of the problems in referenced in posts 

	"2.6.0-test4: Unable to handle kernel NULL pointer dereference"
	"2.6.0-test4-mm2: fdisk causes Oops" (I get it with Lilo)
	"2.6.0-test4 and hardware reports a non fatal incident"

Am I right in assuming that these are all related problems?  It seems that they all appeared at once, when I went to 2.6.0-test4-mm2.


And, did these get fixed with 2.6.0-test4-mm3 ?

Thanks

Garrett
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
