Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVC3UqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVC3UqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVC3UqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:46:21 -0500
Received: from www.webclippings.com ([38.144.36.11]:60567 "EHLO
	allresearch.com") by vger.kernel.org with ESMTP id S262434AbVC3Upy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:45:54 -0500
Message-ID: <424B0FF7.4090601@allresearch.com>
Date: Wed, 30 Mar 2005 12:45:43 -0800
From: Noah Silverman <noah@allresearch.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hangcheck problem
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm been experiencing a weird problem....

I get endlessly repeated hangcheck errors in my syslog with no explanation:

Mar 30 12:41:43 db kernel: Hangcheck: hangcheck value past margin!

Eventually, after a few weeks, the box will hang.  It is pingable, but I
can't ssh or connect to any servcie.

I would love to diagnose the problem, but the syslog entries don't give
me much to go on.

Does anybody have any suggestions.

Thanks,

-Noah
