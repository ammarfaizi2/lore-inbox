Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293005AbSBVVXX>; Fri, 22 Feb 2002 16:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293003AbSBVVXE>; Fri, 22 Feb 2002 16:23:04 -0500
Received: from codepoet.org ([166.70.14.212]:23271 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S287552AbSBVVWw>;
	Fri, 22 Feb 2002 16:22:52 -0500
Date: Fri, 22 Feb 2002 14:22:52 -0700
From: Erik Andersen <andersen@codepoet.org>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
Message-ID: <20020222212252.GA30290@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	=?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
	Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020222200750.GE9558@kroah.com> <20020221221842.V1779-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020221221842.V1779-100000@gerard>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 21, 2002 at 10:24:22PM +0100, Gérard Roudier wrote:
> 
> Thanks for the reply. But my concern is user convenience in _average_
> here. Basically, I want the 99% of users that cannot afford neither need
> nor want PCI hotplug to have their system just dead in order to make happy
> the 1%.

I think _lots_ of people have laptops -- far more than just 1%.  
Those laptops have cardbus slots, which need PCI hotplug to work
properly.  And I _know_ that Linus has a laptop with a cardbus 
slot...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
