Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTKZTbI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTKZTbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:31:08 -0500
Received: from holomorphy.com ([199.26.172.102]:14270 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263402AbTKZTbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:31:07 -0500
Date: Wed, 26 Nov 2003 11:30:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Message-ID: <20031126193059.GS8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200311261212.10166.gene.heskett@verizon.net> <20031126171925.GR8039@holomorphy.com> <200311261415.52304.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311261415.52304.gene.heskett@verizon.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 November 2003 12:19, William Lee Irwin III wrote:
>> echo 1 > /proc/sys/vm/overcommit_memory

On Wed, Nov 26, 2003 at 02:15:52PM -0500, Gene Heskett wrote:
> Unforch, this seems to have fubared the system, and I will have to 
> reboot as I cannot (it hangs) do an "su amanda" after executeing 
> this.

Sounds like trouble. Are there any external signs of what's going on?
e.g. is the disk thrashing?


-- wli
