Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967812AbWLDXb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967812AbWLDXb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967813AbWLDXb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:31:28 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:62051 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967812AbWLDXb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:31:28 -0500
Message-ID: <4574ABB1.8000301@wolfmountaingroup.com>
Date: Mon, 04 Dec 2006 16:13:53 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: scst support for kernels above 2.6.15
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noticed that scsi_do_req has apparently been obsoleted in 2.6.18 
and above.  Is scst and target support for FC-AL going to
remain supported and/or merged at some point?   If so, what is planned 
for scst support for later kernels?

Jeff
