Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265989AbUAEWio (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUAEWh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:37:27 -0500
Received: from main.gmane.org ([80.91.224.249]:38627 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265985AbUAEWfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:35:53 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [ANNOUNCE] 2004-01-05 release of hotplug scripts
Date: Mon, 05 Jan 2004 23:35:45 +0100
Message-ID: <yw1xllom10se.fsf@ford.guide>
References: <20040105183058.GA22066@kroah.com> <1073341146.6075.352.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:VOXsKzucCQAnmBhhbZt/CIRaT0c=
Cc: linux-hotplug-devel@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer <azarah@nosferatu.za.org> writes:

> Seems there is an issue with hotplug.functions .. attached correct
> patch?

It's not correct.  It's got ^M line ends.

-- 
Måns Rullgård
mru@kth.se

