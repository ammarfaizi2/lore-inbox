Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVIDKiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVIDKiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 06:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVIDKiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 06:38:51 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:28877 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750741AbVIDKiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 06:38:50 -0400
Date: Sun, 4 Sep 2005 12:35:23 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Bret Towe <magnade@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs4 client bug
Message-ID: <20050904103523.GA5613@electric-eye.fr.zoreil.com>
References: <dda83e78050903171516948181@mail.gmail.com> <dda83e7805090320053b03615d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dda83e7805090320053b03615d@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bret Towe <magnade@gmail.com> :
[...]
> after moving some files on the server to a new location then trying to
> add the files
> to xmms playlist i found the following in dmesg after xmms froze
> wonder how many more items i can find...

The system includes some binary only stuff. Please contact your vendor
or provide the traces for a configuration wherein the relevant module
was not loaded after boot. It may make sense to get in touch with
nfs@lists.sourceforge.net then.

--
Ueimor
