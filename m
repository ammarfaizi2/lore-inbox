Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUJNSkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUJNSkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUJNSbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:31:32 -0400
Received: from fmr04.intel.com ([143.183.121.6]:62368 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266891AbUJNRxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 13:53:48 -0400
Message-ID: <416EBD01.3010708@intel.com>
Date: Thu, 14 Oct 2004 10:53:05 -0700
From: Arun Sharma <arun.sharma@intel.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Support ia32 exec domains without CONFIG_IA32_SUPPORT
References: <41643EC0.1010505@intel.com> <20041007142710.A12688@infradead.org> <4165D4C9.2040804@intel.com> <mailman.1097223239.25078@unix-os.sc.intel.com> <41671696.1060706@intel.com> <mailman.1097403036.11924@unix-os.sc.intel.com> <416AF599.2060801@intel.com> <1097617824.5178.20.camel@localhost.localdomain> <416C5ECF.6060402@intel.com> <20041014085003.GM31909@devserv.devel.redhat.com>
In-Reply-To: <20041014085003.GM31909@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2004 1:50 AM, Jakub Jelinek wrote:

> There is no point in calling __emul_prefix () when it will be thrown away.

This is addressed in the most recent patch posted to the mailing list.

	-Arun
