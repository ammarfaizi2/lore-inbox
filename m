Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWI1Nyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWI1Nyi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161133AbWI1Nyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:54:38 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:40232 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161129AbWI1Nyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:54:37 -0400
In-Reply-To: <20060928132540.GA18933@wohnheim.fh-wedel.de>
Subject: Re: [S390] hypfs sparse warnings.
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF23094A82.EDC81A74-ON422571F7.004C2D9B-422571F7.004C7025@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Thu, 28 Sep 2006 15:54:54 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 28/09/2006 15:56:34
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörn,

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote on 09/28/2006 03:25:40 PM:

> On Thu, 28 September 2006 15:07:37 +0200, Martin Schwidefsky wrote:
> >
> > sparse complains, if we use bitwise operations on enums. Cast enum to
> > long in order to fix that problem!
>
> At this point I start to wonder which part should be changed.  Is it
> better to
> a) cast some more, as you started to do,

I have done that! Martin already has submitted this patch.

Michael

