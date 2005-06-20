Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVFTTZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVFTTZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVFTTZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 15:25:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17566 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261523AbVFTTYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 15:24:23 -0400
Subject: Re: ITE IT8212 ATA RAID Controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Paradise <paradyse@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <b6fcc0a050620032413f7d3e3@mail.gmail.com>
References: <f2176eb805062003041cc3606b@mail.gmail.com>
	 <b6fcc0a050620032413f7d3e3@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119295317.3325.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 20:22:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-06-20 at 11:24, Alexey Dobriyan wrote:
> On 6/20/05, Paradise <paradyse@gmail.com> wrote:
> >   Please tell me the offcial kernel and the mm kernel if they are
> > support IT8212 driver or not?
> 
> Included in 2.6.12-mm1.

iteraid is but that requires massive surgery while the -ac one just
works. Its unfortunate that maintainer politics has ruining the Linux
experience of so many users for months.

Alan

