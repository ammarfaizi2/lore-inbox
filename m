Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUCaI3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 03:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUCaI3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 03:29:13 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:36761 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261830AbUCaI3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 03:29:12 -0500
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.5-rc3-mm1
Date: Wed, 31 Mar 2004 08:29:11 +0000 (UTC)
Organization: Cistron
Message-ID: <c4dvgn$d30$1@news.cistron.nl>
References: <1Fylv-df-27@gated-at.bofh.it> <1FAwU-2gc-11@gated-at.bofh.it> <1FAQv-2wA-57@gated-at.bofh.it> <m3lllh4ghg.fsf@averell.firstfloor.org>
X-Trace: ncc1701.cistron.net 1080721751 13408 62.216.30.38 (31 Mar 2004 08:29:11 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen  <ak@muc.de> wrote:
>> 2.6.5-rc2 booting OK(with acpi), anything else 2.6.5-rc2-mm?,
>> 2.6.5-rc3 or2.6.5-rc3-mm1 freezes.
>Could you perhaps build your kernel with netconsole and builtin
>network driver (see Documentation/networking/netconsole.txt) and get
>a full boot log?  You can send it to me privately.

Compaq presario 700 laptop:
2.6.5-rc3-mm1 gives timeout on /dev/hda while booting.
2.6.5-rc2-mm3 works fine.

Danny

-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

