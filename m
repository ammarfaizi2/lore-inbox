Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbTKPDlm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 22:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTKPDlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 22:41:42 -0500
Received: from pan.togami.com ([66.139.75.105]:58605 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S261740AbTKPDll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 22:41:41 -0500
Subject: Status of dpt_i2o? (Adaptec 2110S)
From: Warren Togami <warren@togami.com>
To: kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1068954098.4379.66.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 15 Nov 2003 17:41:39 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the status of dpt_i2o with the 2.6 kernel?  Has any work been
done to improve its non-x86 arch compatibility?

I am concerned here because my new servers have Adaptec 2110S SCSI RAID
controllers less than 6 months old, and it appears that as of the next
release of Fedora Core I will no longer be able to upgrade my servers
due to the lack of dpt_i2o driver.

I am also disheartened that the dpt_i2o driver never did seem to work in
alternate architectures.

Warren Togami
warren@togami.com

