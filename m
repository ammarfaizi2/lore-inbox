Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTJGN4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 09:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJGN4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 09:56:39 -0400
Received: from fmr05.intel.com ([134.134.136.6]:32689 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262332AbTJGN4g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 09:56:36 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: RFC: changes to microcode update driver.
Date: Tue, 7 Oct 2003 06:56:29 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AFF5@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RFC: changes to microcode update driver.
Thread-Index: AcOM2agr8C4pvcW0R0GgsQ3AyJib2wAACj6g
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Tigran Aivazian" <tigran@veritas.com>,
       "Giacomo A. Catenazzi" <cate@debian.org>
Cc: <linux-kernel@vger.kernel.org>, <simon@urbanmyth.org>
X-OriginalArrivalTime: 07 Oct 2003 13:56:29.0838 (UTC) FILETIME=[CEE502E0:01C38CDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Tigran pointed out, we are active in this area too. At this point we
want to add support of the extended update format to the driver, before
we ship the latest microcode data. Some of them require the new format.

	Jun
> -----Original Message-----
> From: Tigran Aivazian [mailto:tigran@veritas.com]
> Sent: Tuesday, October 07, 2003 6:48 AM
> To: Giacomo A. Catenazzi
> Cc: linux-kernel@vger.kernel.org; simon@urbanmyth.org; Nakajima, Jun
> Subject: Re: RFC: changes to microcode update driver.
> 
> On Tue, 7 Oct 2003, Giacomo A. Catenazzi wrote:
> > Is microcode_ctl still maintained? I've made some
correction/extentions
> but now
> > new from the maintainer.
> 
> Yes, I believe Simon is alive and well. (but busy, as we all are)
> 
> > Intel give us the new microcode? I had contact with the new
> contact/maintainer/?
> > person in Intel, but still no new microcode since summer 2001. So
maybe
> before
> > changing the driver, could you check the Intel vision about Linux
and
> microcode?
> 
> I am communicating with Intel guys from time to time and there are
some
> interesting changes from Intel in the pipeline to update the driver,
but I
> thought it is worthwhile to cleanup and throw away unnecessary bits
before
> applying a major update (otherwise we would be wasting time debugging
an
> update to code which is no longer needed).
> 
> As for the microcode data itself, no, I haven't received anything new
from
> Intel yet but please be patient. I have received unofficial latest
> "hacked"  version of microcode data from someone (outside Intel) but
it
> will not be uploaded because it will cause support problems both to
Intel
> and myself.
> 
> I find it is wiser to be friendly with Intel than to annoy them with
> constant questions "where is the latest microcode data" :)
> 
> Kind regards
> Tigran
> 
> 
> 
> 

