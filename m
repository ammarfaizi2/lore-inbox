Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUBRLm6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUBRLm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:42:57 -0500
Received: from main.gmane.org ([80.91.224.249]:50132 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265698AbUBRLm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:42:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Patrick Beard" <patrick@scotcomms.co.uk>
Subject: Kernel 2.60 i810 Framebuffer.
Date: Wed, 18 Feb 2004 11:42:49 -0000
Message-ID: <c0vj3p$4go$1@sea.gmane.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gateway.scotcomms.co.uk
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not a show stopper problem, but its annoying.

I'm using kernel 2.60 with framebuffer support for i810. All is working
well except when I shutdown from while in iceWM. If I issue a shutdown
from xterm, then X stops and the console displays normally i.e. the text
that was there before X started, but it doesn't refresh and show the
shutdown sequence, instead the screen remains static. If I log into a
console on tty(x) and then shutdown, the shutdown sequence is shown.

Hope I explained this ok.

Any Ideas?

--
Patrick



