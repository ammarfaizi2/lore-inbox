Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVLNGqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVLNGqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 01:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVLNGqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 01:46:22 -0500
Received: from femail.waymark.net ([206.176.148.84]:3471 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1751135AbVLNGqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 01:46:21 -0500
Date: 14 Dec 2005 06:45:42 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: [SERIAL, -mm] CRC failure
To: linux-kernel@vger.kernel.org
Message-ID: <403eda.8e05b5@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Three -mm kernels of late, and now v2.6.15-rc5-mm2, give
frequent z-modem crc errors with minicom, lrz, and an external v90 modem
to a couple of local bb's.  2.6.15-rc5-git2 and before are okay.
--
