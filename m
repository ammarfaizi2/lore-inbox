Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbULDRk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbULDRk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbULDRk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 12:40:59 -0500
Received: from sycorax.lbl.gov ([128.3.5.196]:58572 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S262562AbULDRkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 12:40:53 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc3
References: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
	<pan.2004.12.04.09.06.09.707940@nn7.de>
	<87oeha6lj1.fsf@sycorax.lbl.gov> <cosrt1$j67$1@sea.gmane.org>
From: Alex Romosan <romosan@sycorax.lbl.gov>
Date: Sat, 04 Dec 2004 09:40:51 -0800
In-Reply-To: <cosrt1$j67$1@sea.gmane.org> (message from Ari Pollak on Sat,
 04 Dec 2004 12:24:57 -0500)
Message-ID: <87eki66jx8.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ari Pollak <aripollak@gmail.com> writes:

> Alex Romosan wrote:
>> well, it's still more than my thinkpad which doesn't want to wake up
>> from sleep anymore.
>
> My thinkpad will resume fine if I remove the intel8x0 and intel8x0m
> ALSA modules before going into suspend - works with both APM and ACPI,
> though I don't really use ACPI suspend because the battery drains like
> crazy.

i saw there were some changes to alsa cvs having to do with the new
pci device handling. i'll reconfigure the kernel with alsa as modules
and try alsa cvs to see if that makes any difference. thanks.

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
