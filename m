Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWARQ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWARQ5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWARQ5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:57:45 -0500
Received: from fmr18.intel.com ([134.134.136.17]:14308 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751265AbWARQ5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:57:44 -0500
Date: Wed, 18 Jan 2006 08:58:19 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Mathieu =?ISO-8859-1?B?QulyYXJk?= <Mathieu.Berard@crans.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/3] libata-acpi:more debugging
Message-Id: <20060118085819.707776a8.randy_d_dunlap@linux.intel.com>
In-Reply-To: <43CE72D0.4070000@crans.org>
References: <43C948D1.9010007@crans.org>
	<20060117121348.2f40e672.randy_d_dunlap@linux.intel.com>
	<43CE72D0.4070000@crans.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006 17:54:40 +0100
Mathieu Bérard <Mathieu.Berard@crans.org> wrote:

> Hi,
> I've just tested 2.6.16-rc1-mm1 which includes these three patches.
> The oops is actually fixed, furthermore, both suspend-to-disk and
> suspend-to-ram are now basically working on my Toshiba M70.
> (this laptop was previously locking on resume due to its SATA disk)
> Many thanks.

Thanks for your feedback (all of it:  oops and this message).

---
~Randy [MPG MPAD MSAE SSA]
