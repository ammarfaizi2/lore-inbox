Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318389AbSIBTjY>; Mon, 2 Sep 2002 15:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318407AbSIBTjY>; Mon, 2 Sep 2002 15:39:24 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:41745 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S318389AbSIBTjX>; Mon, 2 Sep 2002 15:39:23 -0400
Date: Mon, 02 Sep 2002 13:42:40 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Doug Ledford <dledford@redhat.com>
cc: CAMTP guest <camtp.guest@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <1295910000.1030995760@aslan.scsiguy.com>
In-Reply-To: <20020902140509.A10976@redhat.com>
References: <15731.22574.493121.798425@proizd.camtp.uni-mb.si>
 <1231170000.1030981811@aslan.scsiguy.com> <20020902140509.A10976@redhat.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, it looked to me like there was a bus hang,

This is the actual part I want to understand.  The problems with the
mid-layer are already well known. 8-)

>From the more complete logs I've now received it appears that the cdrom
drive is just not responding within the time allowed which sends us into
recovery.

--
Justin
