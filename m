Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTKETr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTKETr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:47:56 -0500
Received: from main.gmane.org ([80.91.224.249]:21946 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263166AbTKETra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:47:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Pseudo disk interface
Date: Wed, 05 Nov 2003 20:47:27 +0100
Message-ID: <yw1xvfpyvbqo.fsf@kth.se>
References: <e9bdb4e9ef4a.e9ef4ae9bdb4@usc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:03j2oimunjFoNLPm6C09JJfulrQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

balaji raghavan <braghava@usc.edu> writes:

>     Is there a some kind of __disk_abstraction__ existent in Linux? I
> am trying to write a Cryptographic disk driver for linux. But AFAIK, I

There already exists such a driver, at least in Linux 2.6.  It's part
of (or at least related to) the loopback driver.

-- 
Måns Rullgård
mru@kth.se

