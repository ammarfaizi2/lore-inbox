Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUCBFPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 00:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUCBFPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 00:15:37 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:32469
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261564AbUCBFPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 00:15:36 -0500
Message-ID: <4044185A.9080105@redhat.com>
Date: Mon, 01 Mar 2004 21:15:06 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Selbak, Rolla N" <rolla.n.selbak@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PTS test pass results - (CVS pull 2-20-04, Kernel 2.6.1)
References: <0258DE86469E2641A0C1B4C734EB88510197409F@orsmsx407.jf.intel.com>
In-Reply-To: <0258DE86469E2641A0C1B4C734EB88510197409F@orsmsx407.jf.intel.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selbak, Rolla N wrote:
> POSIX Test Suite test pass results available for [CVS pull 2-20-04,
> Kernel 2.6.1, libc-2004-02-01 and message queue 
> 4.17 patch]. 

Before you publish results, please fix the bugs in the test suite.  I'm
pretty sure I already reported them.  My current set of patches is at

  http://people.redhat.com/drepper/d-pts-ud

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
