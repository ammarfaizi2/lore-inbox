Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTLHXSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTLHXSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:18:03 -0500
Received: from mail47-s.fg.online.no ([148.122.161.47]:3542 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP id S262070AbTLHXSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:18:01 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matthieu.Moy@imag.fr, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: BTTV option not available in make gconfig
References: <vpq1xrfnd49.fsf@ecrins.imag.fr> <yw1xzne2aphn.fsf@kth.se>
	<20031208145347.10db1b52.rddunlap@osdl.org>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 09 Dec 2003 00:17:50 +0100
In-Reply-To: <20031208145347.10db1b52.rddunlap@osdl.org> (Randy Dunlap's
 message of "Mon, 8 Dec 2003 14:53:47 -0800")
Message-ID: <yw1xvfoqaogx.fsf@kth.se>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> | > The option CONFIG_VIDEO_BT848=m in .config was available in 2.4, but I
> | > can't find in  doing a "make gconfig" in the new  version. (This is to
> | > manage my Pinnacle PCTV card)
> | 
> | Say Y or M to I2O support.
>
> I2C instead of I2O ???

Yes, of course.

-- 
Måns Rullgård
mru@kth.se
