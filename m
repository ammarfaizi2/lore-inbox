Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbTFYUVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTFYUVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:21:08 -0400
Received: from fmr06.intel.com ([134.134.136.7]:39642 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265036AbTFYUVC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:21:02 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH 2.4] ACPI_HT_ONLY acpismp=force
Date: Wed, 25 Jun 2003 13:35:11 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FCF@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.4] ACPI_HT_ONLY acpismp=force
Thread-Index: AcM7V+HrSyU29GbBQo2rRnpwLF/V3gAAOttg
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "Arjan van de Ven" <arjanv@redhat.com>, "Andrew Morton" <akpm@digeo.com>,
       "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jun 2003 20:35:12.0127 (UTC) FILETIME=[46BAA0F0:01C33B59]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hugh Dickins [mailto:hugh@veritas.com] 

> What's the point of bootparam "acpismp=force"?  A way to change
> your mind if you just said "acpi=off"?  A hurdle to jump to get
> CONFIG_ACPI_HT_ONLY to do what you ask?  2.4.18 used to need it to
> enable HT, but not recent releases.  It can't configure in what's
> not there, and now serves only to confuse: kill it.

Sounds good to me. I was confused about the necessity of keeping
acpismp=force around. Sorry bout that.

Thanks -- Regards -- Andy
