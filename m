Return-Path: <linux-kernel-owner+w=401wt.eu-S932717AbWLZQwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWLZQwc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 11:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWLZQwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 11:52:32 -0500
Received: from terminus.zytor.com ([192.83.249.54]:58477 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717AbWLZQwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 11:52:31 -0500
Message-ID: <459152B1.9040106@zytor.com>
Date: Tue, 26 Dec 2006 08:49:53 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: nigel@nigel.suspend2.net
CC: "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
References: <20061214223718.GA3816@elf.ucw.cz>	 <20061216094421.416a271e.randy.dunlap@oracle.com>	 <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com>	 <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net>
In-Reply-To: <1166304080.13548.8.camel@nigel.suspend2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> I've have git trees against a few versions besides Linus', and have just
> moved all but Linus' to staging to help until you can get your new
> hardware. If others were encouraged to do the same, it might help a lot?
> 

Not really.  In fact, it would hardly help at all.

The two things git users can do to help is:

1. Make sure your alternatives file is set up correctly;
2. Keep your trees packed and pruned, to keep the file count down.

If you do this, the load imposed by a single git tree is fairly negible.

	-hpa
