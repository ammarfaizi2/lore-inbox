Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264210AbTDKKCj (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 06:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTDKKCi (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 06:02:38 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:50349 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S264210AbTDKKCi (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 06:02:38 -0400
Date: Fri, 11 Apr 2003 06:10:24 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel support for non-english user messages
To: DevilKin <devilkin-lkml@blindguardian.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304110613_MC3-1-33F7-C4B8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>linux dmesg=verbose
>
>and
>
>linux dmesg=quiet


 You really need "dmesg=normal" as well, unless you are calling the
current behavior verbose.  After seeing FreeBSD in bootverbose
mode, I wouldn't...

--
 Chuck
 I am not a number!
