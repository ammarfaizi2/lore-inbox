Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTDOHqV (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 03:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbTDOHqV (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 03:46:21 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:24311 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S264382AbTDOHqU (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 03:46:20 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 (4/16): s390 console changes.
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF4C3F1A44.16B87621-ONC1256D09.002AEB2C@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 15 Apr 2003 09:57:07 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 15/04/2003 09:57:56
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > s390 console fixes for 3215 and sclp.
>
> Are you going to backport this to 2.4?

There is no reason to touch the 3215 code which is
working just fine in 2.4. As for the new sclp code,
yes we plan to backport all the fixes the new 2.4
sclp code.

blue skies,
   Martin


