Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311289AbSCLRCI>; Tue, 12 Mar 2002 12:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311292AbSCLRB6>; Tue, 12 Mar 2002 12:01:58 -0500
Received: from ns.ithnet.com ([217.64.64.10]:5137 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S311289AbSCLRBv>;
	Tue, 12 Mar 2002 12:01:51 -0500
Date: Tue, 12 Mar 2002 18:01:42 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Jo?o" Bonina <bonina_2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Networking problem with Realtek RTL8139
Message-Id: <20020312180142.3913483c.skraw@ithnet.com>
In-Reply-To: <20020312165154.82548.qmail@web12704.mail.yahoo.com>
In-Reply-To: <20020312165154.82548.qmail@web12704.mail.yahoo.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002 08:51:54 -0800 (PST)
 "João"  Bonina <bonina_2001@yahoo.com> wrote:

> Hello all!
> 
> I'm having some networking problems with my Realtek
> RTL8139 network card (I'm using Suse 7.2 which
> installs Kernel 2.4.4, I guess).
> 
> The host hangs and the card's led starts flashing when
> I do the following:
> - access the X server remotely
> - in a FTP session during file transfer
> - in a TELNET session, sometimes.
> 
> After that all network access is dead.
> 
> The 8139too module is the one installed for the card.
> 
> How do I solve this problem?

How about a kernel upgrade? 14 revisions later _can_ make a difference ;-)

Regards,
Stephan

