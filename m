Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUCRFOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 00:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUCRFOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 00:14:07 -0500
Received: from alt.aurema.com ([203.217.18.57]:6298 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262391AbUCRFOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 00:14:03 -0500
Message-ID: <40593015.9090507@aurema.com>
Date: Thu, 18 Mar 2004 16:13:57 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: XFree86 seems to be being wrongly accused of doing the wrong thing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.4 I'm getting the following messages very early in the boot 
long before XFree86 is started:

Mar 18 16:05:31 mudlark kernel: atkbd.c: Unknown key released 
(translated set 2, code 0x7a on isa0060/serio0).
Mar 18 16:05:31 mudlark kernel: atkbd.c: This is an XFree86 bug. It 
shouldn't access hardware directly.

They are repeated 6 times and are NOT the result of any keys being 
pressed or released.

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

