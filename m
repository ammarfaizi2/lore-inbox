Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTJFSWi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTJFSWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:22:37 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:54745 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263195AbTJFSWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:22:34 -0400
Subject: Re: s390 test6 patches: descriptions.
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Florian La Roche <laroche@redhat.com>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OFEBC372A1.ADA2F842-ONC1256DB7.0064A663-C1256DB7.0064E082@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 6 Oct 2003 20:21:50 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 20:22:23
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> This is all fine, but the removal of dst_link_failure is missing.
> Why is that? We agreed about it several update cycles before.
> I am not doing because I'm bored, we hit actual oopses (ok, on 2.4).

This is one of the cases of "If you don't do it yourself, nobody will".
I am no expert in regard to network drivers but I'll check in your
patch now. Fritz seems to be too busy to do it himself.

blue skies,
   Martin


