Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVIJXYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVIJXYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVIJXYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:24:12 -0400
Received: from smtp05.auna.com ([62.81.186.15]:58001 "EHLO smtp05.retemail.es")
	by vger.kernel.org with ESMTP id S932374AbVIJXYL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:24:11 -0400
Date: Sat, 10 Sep 2005 23:24:12 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050909214542.GA29200@kroah.com>
In-Reply-To: <20050909214542.GA29200@kroah.com> (from gregkh@suse.de on Fri
	Sep  9 23:45:42 2005)
X-Mailer: Balsa 2.3.4
Message-Id: <1126394652l.6738l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.208.222] Login:jamagallon@able.es Fecha:Sun, 11 Sep 2005 01:24:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.09, Greg KH wrote:
> Here are the same "delete devfs" patches that I submitted for 2.6.12.

Would this be accompained with deleting all the devfs compat scripts in
udev (for 069) ? ;)

Or at least a split in a different package ?

Thanks.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.13-jam3 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))


