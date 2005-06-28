Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVF1Lax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVF1Lax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVF1Lax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:30:53 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:16609 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261317AbVF1Lau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:30:50 -0400
Subject: Re: 2.6.X not recognizing second CPU
From: Erik Slagter <erik@slagter.name>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Haninger <ahaning@gmail.com>, Jim serio <jseriousenet@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050627214249.GA29657@isilmar.linta.de>
References: <3642108305062711524e1e163@mail.gmail.com>
	 <105c793f050627123583a70d0@mail.gmail.com>
	 <3642108305062713487326b672@mail.gmail.com>
	 <105c793f05062714022ad4359@mail.gmail.com>
	 <20050627214249.GA29657@isilmar.linta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jun 2005 13:32:59 +0200
Message-Id: <1119958379.3969.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 23:42 +0200, Dominik Brodowski wrote:
> a) Power Management is available on SMP, though support for it is a bit less
>    wide-spread than it is for UP

Still no C2/C3 handling :-(
