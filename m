Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTIYKYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbTIYKYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:24:24 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:65535 "EHLO
	cpmx.mail.saic.com") by vger.kernel.org with ESMTP id S261798AbTIYKXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:23:52 -0400
Subject: SIDN failure on 2.6.0-test5-*
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064485424.22241.4.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Sep 2003 11:23:44 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks.

I'm trying ( occasionally :) to try out the 2.6 series on my home setup.

Everything appears to work fine, except my ISDN card. It's a HiSax based
type 35, using the 2BDS0 driver. When the kernel tries to initialise it,
it complains bitterly, with many "PUT 0->1" and "PUT 1->0 " errors,
followed by link failures etc from ippd.

Is this supposed to work yet, as I asked a while back and it was still a
work in progress.

Any information gratefully received ( and I can supply more detailed
failure reports if required or helpful :)

Cheers,
Eamonn


