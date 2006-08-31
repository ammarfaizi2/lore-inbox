Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWHaRha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWHaRha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWHaRh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:37:29 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:4613 "EHLO mms1.broadcom.com")
	by vger.kernel.org with ESMTP id S932327AbWHaRh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:37:28 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
Subject: Re: PROBLEM: HT1000 drops network packets during disk writes
From: "Michael Chan" <mchan@broadcom.com>
To: aizvorski@gmail.com
cc: linux-kernel@vger.kernel.org
Date: Thu, 31 Aug 2006 10:36:08 -0700
Message-ID: <1157045768.7548.5.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006083107; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230322E34344637314430332E303030342D412D;
 ENG=IBF; TS=20060831173724; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006083107_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68E9C1DA3CC3535303-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Izvorski wrote:

> [1.] One line summary of the problem:
> HT1000 drops network packets during disk writes

ServerWorks is able to reproduce the problem, and so we'll be looking
into it.

Thanks.

