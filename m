Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTENSJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTENSJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:09:13 -0400
Received: from fmr06.intel.com ([134.134.136.7]:59588 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262351AbTENSJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:09:13 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCB0943@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Shaheed R. Haque'" <srhaque@iee.org>,
       "'Zwane Mwaikambo'" <zwane@linuxpower.ca>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6 must-fix list, v2
Date: Wed, 14 May 2003 11:21:29 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
> From: Shaheed R. Haque [mailto:srhaque@iee.org]
>
> Can I be certain that there is no shared lock or anything else in the
whole
> kernel? No, but I'm prepared to make that probabalistic tradeoff (backed
via
> extensive testing) rather than have to go to hard-realtime.

An of course, when you pin one of those, you try to "fix it",
so to improve the time response of the kernel ...

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
