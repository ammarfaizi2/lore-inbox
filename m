Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267588AbTACRNJ>; Fri, 3 Jan 2003 12:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267591AbTACRNJ>; Fri, 3 Jan 2003 12:13:09 -0500
Received: from 177-2.SPEEDe.golden.net ([216.75.177.2]:53513 "EHLO
	thebeever.com") by vger.kernel.org with ESMTP id <S267588AbTACRNJ>;
	Fri, 3 Jan 2003 12:13:09 -0500
Date: Fri, 3 Jan 2003 12:22:16 -0500
From: Richard Baverstock <beaver@gto.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AGPGART for VIA vt8235, kernel 2.4.21-pre2
Message-Id: <20030103122216.39cedd3f.beaver@gto.net>
In-Reply-To: <20030103171617.B4502@ucw.cz>
References: <20030102145346.27a21ed9.beaver@gto.net>
	<20030103171617.B4502@ucw.cz>
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The vt8235 is the southbridge chip and that the AGP bridge is
> located in the northbridge, which most likely has a different number.

Sorry about that, thought the AGP was in the southbridge chip. I see however that someone else has submitted a patch with the correct naming conventions (It does seem to change between P4X333 and P4X400 however). Thanks for the heads up :)

Rich

