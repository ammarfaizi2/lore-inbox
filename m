Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266381AbUGBCmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUGBCmh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 22:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUGBCmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 22:42:37 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:51633 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S266381AbUGBCmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 22:42:35 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: SATA problems in 2.6.7-mm[1,5] vanilla works
Date: Fri, 2 Jul 2004 02:42:35 +0000 (UTC)
Organization: Cistron
Message-ID: <cc2i2r$6ta$2@news.cistron.nl>
References: <200407012352.16816.cova@ferrara.linux.it> <40E48817.3060901@pobox.com> <200407020025.02274.cova@ferrara.linux.it>
X-Trace: ncc1701.cistron.net 1088736155 7082 62.216.30.38 (2 Jul 2004 02:42:35 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Coatti  <cova@ferrara.linux.it> wrote:
>Alle 23:54, giovedì 1 luglio 2004, Jeff Garzik ha scritto:
>> Fabio Coatti wrote:
>> > I'm having problems with sata starting from 2.6.7-mm1:
>> > the system hangs at boot, during the sata bus scan.
>>
>> does 'acpi=off' fix the problem?
>
>Nope, just tried..I've also reverted bk-acpi patch, without any change. (on 
>mm5)

Strange, since my problem (ICH5 sata controller) does function with
acpi=off . What hardware do you have ? (mobo/controller)

Danny

-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

