Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbTIQNmx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 09:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTIQNmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 09:42:53 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:42919 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262757AbTIQNmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 09:42:52 -0400
Subject: RE: Kernel NMI error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: msrinath <msrinath@bplitl.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <007c01c37d01$47622700$1d03000a@srinath>
References: <007c01c37d01$47622700$1d03000a@srinath>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063806072.12270.33.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Wed, 17 Sep 2003 14:41:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 10:51, msrinath wrote:
> Thanks for the reply. This is the only time this has ever happened. How can
> I make out if it is a memory error? Is there any way by which I can test it?

If you can schedule down time for the machine run memtest86 on it for a
few hours to check. If not just see if it happens again I guess, if so
then think about testing the RAM

