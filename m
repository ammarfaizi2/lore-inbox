Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293040AbSBVX1x>; Fri, 22 Feb 2002 18:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293043AbSBVX1n>; Fri, 22 Feb 2002 18:27:43 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12043 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293040AbSBVX1a>;
	Fri, 22 Feb 2002 18:27:30 -0500
Date: Fri, 22 Feb 2002 20:27:12 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Cc: Greg KH <greg@kroah.com>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <20020221221842.V1779-100000@gerard>
Message-ID: <Pine.LNX.4.33L.0202222024500.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Gérard Roudier wrote:

> Thanks for the reply. But my concern is user convenience in _average_
> here. Basically, I want the 99% of users that cannot afford neither
> need nor want PCI hotplug to have their system just dead in order to
> make happy the 1%.

Following this logic, we should just fix the thing for
laptop users and ignore the few folks who run multiple
SCSI busses, right ?

Of course you'll shout bloody murder since you're part
of the 1% now ;)

I guess we want a solution which works for both situations,
instead of people discouraging each other from fixing the
kernel for situations they're not experiencing themselves.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

