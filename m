Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWD0Iaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWD0Iaf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWD0Iaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:30:35 -0400
Received: from webmail-outgoing2.us4.outblaze.com ([205.158.62.67]:54485 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S964979AbWD0Iae convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:30:34 -0400
X-OB-Received: from unknown (208.36.123.30)
  by wfilter.us4.outblaze.com; 27 Apr 2006 08:24:56 -0000
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
From: "Artem Tashkinov" <t.artem@lycos.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Apr 2006 00:29:22 -0800
Subject: A possibility of turning off file caching for certain operations
X-Originating-Ip: 84.254.208.53
X-Originating-Server: ws7-1.us4.outblaze.com
Message-Id: <20060427082922.77DB586B12@ws7-1.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A nice feature of emptying files and buffer cache was introduced in kernel 2.6.16 but my question is: Is it possible to turn off file caching for certain operations? E.g. I do not want the kernel to cache an ISO image which is being copied from HDD to the LAN or burned to CD.

Best wishes, Artem


-- 
_______________________________________________

Search for businesses by name, location, or phone number.  -Lycos Yellow Pages

http://r.lycos.com/r/yp_emailfooter/http://yellowpages.lycos.com/default.asp?SRC=lycos10

