Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270283AbTHBU0r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270291AbTHBU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 16:26:47 -0400
Received: from holomorphy.com ([66.224.33.161]:6373 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270283AbTHBU0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 16:26:46 -0400
Date: Sat, 2 Aug 2003 13:28:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: .config in bzImage ?
Message-ID: <20030802202803.GD32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	linux-kernel@vger.kernel.org
References: <20030802192957.GC32488@holomorphy.com> <E19j2sd-0003VB-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19j2sd-0003VB-00@calista.inka.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030802192957.GC32488@holomorphy.com> you wrote:
>> IIRC this hit current 2.6 bk recently, which probably helps _someone_
>> with administration (and may very well save me some reboots to get into
>> kernels with known .configs).

On Sat, Aug 02, 2003 at 10:21:31PM +0200, Bernd Eckenfels wrote:
> Of course you can simply place the .config along the kernel and the
> System.map in /boot, too.

Which requires having some way to associate the running kernel to those
files.


-- wli
