Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTLEOTg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTLEOTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:19:36 -0500
Received: from holomorphy.com ([199.26.172.102]:33747 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264145AbTLEOTf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:19:35 -0500
Date: Fri, 5 Dec 2003 06:19:28 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: neel vanan <neelvanan@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic...
Message-ID: <20031205141928.GD8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	neel vanan <neelvanan@yahoo.com>, linux-kernel@vger.kernel.org
References: <S263478AbTLEJ0s/20031205092648Z+878@vger.kernel.org> <20031205093435.61652.qmail@web9504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205093435.61652.qmail@web9504.mail.yahoo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 01:34:35AM -0800, neel vanan wrote:
>  Mounting root filesystem
>  mount : erro 6 mounting ext3
>  pivotroot : pivot_root (/sysroot, /sysroot/initrd)
> failed:2
>  umount /initrd/proc failed :2
>  Mounting devfs on /dev
>  freeing unused kernel memory : 464k freed
>  Kernel panic: no init found. Try passing init= option
> to kernel
> After then blinking cursor.

Could you post your .config?


-- wli
