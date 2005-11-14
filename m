Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVKNMYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVKNMYX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbVKNMYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:24:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46047 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751103AbVKNMYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:24:22 -0500
Subject: Re: ADI Blackfin patch for kernel 2.6.14
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Yang <luke.adi@gmail.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <489ecd0c0511132334rc0d8a18n9ccf1bdd30d564a0@mail.gmail.com>
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
	 <20051101165136.GU8009@stusta.de>
	 <489ecd0c0511012306w434d75fbs90e1969d82a07922@mail.gmail.com>
	 <489ecd0c0511032059n394abbb2s9865c22de9b2c448@mail.gmail.com>
	 <20051104230644.GA20625@kroah.com>
	 <489ecd0c0511062258k4183d206odefd3baa46bb9a04@mail.gmail.com>
	 <20051107165928.GA15586@kroah.com> <20051107235035.2bdb00e1.akpm@osdl.org>
	 <489ecd0c0511110326j3a01cabbheeeac6168193a0b0@mail.gmail.com>
	 <20051112214741.GB16334@kroah.com>
	 <489ecd0c0511132334rc0d8a18n9ccf1bdd30d564a0@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Nov 2005 12:53:38 +0000
Message-Id: <1131972818.5751.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-14 at 15:34 +0800, Luke Yang wrote:
>   So the process is: when kernel release a new version, we should
> update our arch related files to the new kernel, then send you the
> patch. Am I right?

That is the ideal case. Also in theory nothing major should change after
-rc1 of each release so nothing should break later on.

Not all of the minor trees work every release but its considered better
if they do.

