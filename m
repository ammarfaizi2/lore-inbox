Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932721AbWFUXfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbWFUXfy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbWFUXfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:35:53 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:1977 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932723AbWFUXfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:35:52 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: Re: Linux 2.4.33-rc2
Date: Thu, 22 Jun 2006 09:35:46 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <krlj925po887kjqvv548ffs9fm4iq1v3tt@4ax.com>
References: <20060621192756.GB13559@dmt>
In-Reply-To: <20060621192756.GB13559@dmt>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 16:27:56 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:

>
>A few problems appeared on -rc1... More networking security updates.
>
>
>Summary of changes from v2.4.33-rc1 to v2.4.33-rc2
>============================================
>
>Marcelo Tosatti:
>      Change VERSION to v2.4.33-rc2
>
>Mikael Pettersson:
>      [PATCH 2.4.33-rc1] repair __ide_dma_no_op breakage
>
>Solar Designer:
>      [NETFILTER]: Fix do_add_counters race, possible oops or info leak (CVE-2006-0039)
>
>Vlad Yasevich:
>      [SCTP]: Validate the parameter length in HB-ACK chunk. (CVE-2006-1857)
>      [SCTP]: Respect the real chunk length when walking parameters. (CVE-2006-1858)
>
>Willy Tarreau:
>      Fix vfs_unlink/NFS NULL pointer dereference
>      range checking for sleep states sent to /proc/acpi/sleep

Things are looking up ;)  <http://bugsplatter.mine.nu/test/linux-2.4/>

+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - +
| kernel version  |deltree|hal    |niner  |peetoo |pooh   |sempro |silly  |tosh   |
+ - - - - - - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - + - - - +
| 2.4.33-rc2      |   Y   |   Y   |   Y   |   Y   |       |   Y   |   Y   |   Y   |
| 2.4.33-rc1      |   -   |   -   |   -   |   -   |       |   X   |   -   |   X   |

Grant.
