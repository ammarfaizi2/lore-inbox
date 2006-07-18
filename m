Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWGRPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWGRPMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWGRPMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:12:37 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:48360 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932270AbWGRPMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:12:36 -0400
Content-Type: multipart/mixed; boundary="===============0530459370=="
MIME-Version: 1.0
Subject: [PATCH 0 of 2] Resend: x86-64: Calgary IOMMU updates
Message-Id: <patchbomb.1153235476@rhun.haifa.ibm.com>
Date: Tue, 18 Jul 2006 18:11:16 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       konradr@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0530459370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Andi,

This is a resend of the patchset Jon sent earlier. The first patch
fixes an off-by-one error and the second patch fixes booting on
multi-node NUMA x460 servers.

Please apply.

Thanks,
Muli

--===============0530459370==--
