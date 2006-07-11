Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWGKVu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWGKVu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWGKVu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:50:59 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:44469 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932144AbWGKVu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:50:58 -0400
Message-ID: <44B41D3F.7010409@oracle.com>
Date: Tue, 11 Jul 2006 14:50:55 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sean Hefty <sean.hefty@intel.com>
CC: "'Michael S. Tsirkin'" <mst@mellanox.co.il>,
       Hal Rosenstock <halr@voltaire.com>, Roland Dreier <rolandd@cisco.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [openib-general] ipoib lockdep warning
References: <000401c6a532$a3017f50$e598070a@amr.corp.intel.com>
In-Reply-To: <000401c6a532$a3017f50$e598070a@amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As a side note, I believe that this is the upstream code and does not include
> the latest multicast changes.

Indeed, I should have mentioned in my report that I was running 2.6.17-mm6.

- z
