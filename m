Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUCHFcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 00:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbUCHFcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 00:32:19 -0500
Received: from [164.164.56.19] ([164.164.56.19]:35738 "EHLO mail1.sasken.com")
	by vger.kernel.org with ESMTP id S262391AbUCHFcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 00:32:18 -0500
From: Swapnil <swapnil@sasken.com>
Subject: fs scheduling access optimization
Date: Mon, 8 Mar 2004 11:02:04 +0530
Message-ID: <Pine.GSO.4.30.0403081100100.17318-100000@sunsv2.sasken.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII

what are various methods to optimize data access from the secondary
memory?
what are the steps taken in designing an efficient and robust fs in terms
of data mgt(not disk space mgt).

Please enlighten

Swapnil S. Garge

--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

***********************************************************************

********************************************************************

SASKEN BUSINESS DISCLAIMER

This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.

***********************************************************************

--=_IS_MIME_Boundary--
