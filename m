Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWHUWKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWHUWKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWHUWKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:10:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751242AbWHUWKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:10:46 -0400
Date: Mon, 21 Aug 2006 15:09:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, akpm@osdl.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       Jens.Osterkamp@de.ibm.com, linas@austin.ibm.com, corbet@lwn.net
Subject: Re: NAPI documentation
Message-ID: <20060821150935.0d59791b@localhost.localdomain>
In-Reply-To: <20060821.150509.111198790.davem@davemloft.net>
References: <200608191325.19557.arnd@arndb.de>
	<200608201948.20596.arnd@arndb.de>
	<20060821134053.7225987b@dxpl.pdx.osdl.net>
	<20060821.150509.111198790.davem@davemloft.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 15:05:09 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Mon, 21 Aug 2006 13:40:53 -0700
> 
> > Please edit and improve
> > 	http://linux-net.osdl.org/index.php/NAPI
> > 
> > When the page is in good shape, I will de-wiki it to place in kernel doc tree.
> 
> How do I edit the introduction paragraphs at the top? 

Click edit on wiki and it is the first sentence.


> I want to edit
> this sentence since it sounds awful:
> 
> 	NAPI ("New API") is a modification to the packet process, ...
> 
> I want to change "packet process" to something more descriptive
> and accurate.
>

Yes.

Also, does Jamal have a link to his UKUUG paper?

-- 
Stephen Hemminger <shemminger@osdl.org>

All non-trivial abstractions, to some degree, are leaky.
