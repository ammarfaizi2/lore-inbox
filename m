Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbTIPRYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbTIPRXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:23:33 -0400
Received: from smtp0.libero.it ([193.70.192.33]:40398 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S262406AbTIPRWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:22:41 -0400
Date: Tue, 16 Sep 2003 19:22:38 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: Badness in as_completed_request in 2.6.0-test5-bk3
Message-ID: <20030916172238.GA9605@ripieno.somiere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Ludovico Gardenghi <dunadan@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <wpjF.63v.17@gated-at.bofh.it> you wrote:

> Try disabling TCQ, I don't think it is very stable for IDE drives.

I tried, and now everything seems fine (both Badness and end-of-disk).

I'll try and see if that strange file corruption still happens or if
it was linked to the TCQ support.

Thanks.

Ludovico
-- 
<dunadan@libero.it>              garden (irc.freenode.net) ICQ: 64483080
GPG ID: 07F89BB8              Jabber: garden@jabber.students.cs.unibo.it
-- This is signature nr. 1230
