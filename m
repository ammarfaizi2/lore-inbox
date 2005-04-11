Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVDKGH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVDKGH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 02:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVDKGH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 02:07:59 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:7583 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S261698AbVDKGHz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 02:07:55 -0400
Date: Mon, 11 Apr 2005 09:35:02 -0400
From: karthik <karthik.r@samsung.com>
Subject: Location of character device of Matrox agpcard driver
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Message-id: <200504110935.02755.karthik.r@samsung.com>
Organization: samsung
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

          Can anybody tell me where the device corresponding to the graphics 
driver 
is created ie whether its in /dev or /sys/class etc in 2.6 kernel.

        Also can i uses ioctls after opening the device to see its working.

Thanks & Regards
Karthik R
