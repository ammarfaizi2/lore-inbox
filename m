Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVESPNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVESPNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVESO7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:59:16 -0400
Received: from main.gmane.org ([80.91.229.2]:56476 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262540AbVESO4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:56:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Soboroff <isoboroff@acm.org>
Subject: Re: ACPI S3/APM suspend
Date: Thu, 19 May 2005 10:49:54 -0400
Message-ID: <9cffywj1d9p.fsf@rogue.ncsl.nist.gov>
References: <9cfvf5gel2l.fsf@rogue.ncsl.nist.gov>
	<9cfzmusbmvw.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rogue.ncsl.nist.gov
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:zVUDR6kx9MpOIudZ47m51c7LkFw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff <isoboroff@acm.org> writes:

> Just tried with 2.6.11.10 using ACPI.  On resume, the mouse doesn't
> respond (there isn't even a cursor).  If I C-A-Backspace out of X, GDM
> needs to be specially HUP'd to restart.  But the mouse still doesn't
> work.

It seems (so far) that APM suspend on 2.6.11.10 works on my laptop.

Thanks to all who offered suggestions.  I think I'll avoid ACPI for
the time being... suspend seems too flaky around
PS2/keyboard/USB/video.

Ian


