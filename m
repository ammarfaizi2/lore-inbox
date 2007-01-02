Return-Path: <linux-kernel-owner+w=401wt.eu-S932636AbXABBZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636AbXABBZ5 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 20:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbXABBZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 20:25:57 -0500
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:50939 "EHLO
	smtp161.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932636AbXABBZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 20:25:56 -0500
Message-ID: <4599B501.4050601@gentoo.org>
Date: Mon, 01 Jan 2007 20:27:29 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: stable@kernel.org, holtmann@redhat.com
CC: linux-kernel@vger.kernel.org,
       Harlan Lieberman-Berg <hlieberman@gentoo.org>
Subject: CVE-2006-6106 (bluetooth CAPI) not fixed in mainline?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch went into 2.6.18.6:
http://marc.theaimsgroup.com/?l=linux-kernel&m=116614741607528&w=2

However it is not included in 2.6.19.x or 2.6.20-rc3. Was this solved in 
mainline another way, are there issues with the patch, or was this 
simply overlooked?

Thanks,
Daniel
