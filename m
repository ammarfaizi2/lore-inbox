Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbSIWS1b>; Mon, 23 Sep 2002 14:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261375AbSIWS1a>; Mon, 23 Sep 2002 14:27:30 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64529
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261372AbSIWS1V>; Mon, 23 Sep 2002 14:27:21 -0400
Subject: Re: 2.5.37 lockup with dbench 36 and make -j3 bzImage and
	PREEMPT=y.
From: Robert Love <rml@tech9.net>
To: Steven Cole <elenstev@mesatop.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032797370.28405.5.camel@spc9.esa.lanl.gov>
References: <1032555932.14946.225.camel@spc9.esa.lanl.gov>
	 <20020921120529.A20153@hh.idb.hist.no>
	 <1032797370.28405.5.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1032805949.25745.21.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 23 Sep 2002 14:32:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-23 at 12:09, Steven Cole wrote:

> Further testing with 2.5.37 over the weekend showed that the lockup also
> occurred without preempt here too.
> 
> This seems to have been fixed in 2.5.38-mm2.  I've run up to dbench 128
> while doing several kernel compiles with make -j3 with PREEMPT enabled,
> and have not observed any lockups at all.

Excellent.  Thanks a lot for this update.

I appreciate your testing, Steven.  Any future preempt-related lock ups
please let me know.

	Robert Love

