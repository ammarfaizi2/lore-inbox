Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031194AbWI0Wz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031194AbWI0Wz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbWI0Wz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:55:59 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:22074 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S965163AbWI0Wz6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:55:58 -0400
X-IronPort-AV: i="4.09,226,1157342400"; 
   d="scan'208"; a="12239833:sNHT19465131"
Message-Id: <6.1.1.1.0.20060927153842.01ece920@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Wed, 27 Sep 2006 18:56:04 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn told me:
>On Wed, 27 September 2006 13:47:16 -0400, Robin Getz wrote:
> >
> > Does anyone have a script that identifies white space problems?
>If you use vim:
>highlight RedundantSpaces ctermbg=red guibg=red
>match RedundantSpaces /\s\+$\| \+\ze\t/

which lead me to:
http://www.vim.org/tips/tip.php?tip_id=1040
and
http://www.vim.org/tips/tip.php?tip_id=811

When you know what to search for - things are much easier to find...

Thanks for the pointer.

-Robin 
