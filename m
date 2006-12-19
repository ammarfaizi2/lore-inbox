Return-Path: <linux-kernel-owner+w=401wt.eu-S932727AbWLSJcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbWLSJcx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 04:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWLSJcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 04:32:53 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:58090 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbWLSJcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 04:32:52 -0500
In-Reply-To: <20061219084357.GG4049@APFDCB5C>
Subject: Re: [PATCH] ehca: fix do_mmap() error check
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OF074F7551.62ED7626-ONC1257249.003467FF-C1257249.003471B9@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Tue, 19 Dec 2006 10:32:49 +0100
X-MIMETrack: Serialize by Router on D12ML065/12/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 19/12/2006 10:32:50
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akinobu!
> The return value of do_mmap() should be checked by IS_ERR().
Thanks again.
Nam

