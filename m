Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUJWDAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUJWDAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJVXSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:18:34 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:57878 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269142AbUJVXNo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:13:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hhA6RgKdh6nOwgxTB7xjACdTFj6dYds3ityps8Mq8Kw8r80c7Cp7KL5ASWE4Ba+xIxsH72CSN/d5gPwNNRQFRVrkXL2zTIO+qoTgJP8hOMOQ2BKZI9LmJj+Dg0QKiUBj8B51L9RgGRzMrZXD9FlaU1K7v9GgHezD0ucAzDZEeHE=
Message-ID: <7aaed09104102216131170194b@mail.gmail.com>
Date: Sat, 23 Oct 2004 01:13:34 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Subject: Re: The naming wars continue...
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41798F74.9090200@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org>
	 <41798F74.9090200@tequila.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2004 07:05 AM, Linus Torvalds wrote:
> Ok,
>  Linux-2.6.10-rc1 is out there for your pleasure.
>
> I thought long and hard about the name of this release (*), since one of
> the main complaints about 2.6.9 was the apparently release naming scheme.
>
> Should it be "-rc1"? Or "-pre1" to show it's not really considered release
> quality yet? Or should I make like a rocket scientist, and count _down_
> instead of up? Should I make names based on which day of the week the
> release happened? Questions, questions..

Do the -rcs first, let them contain everything that should go into the
next release.
And when you feel that you have released enough -rcs(Uh, whenever that
is...) release the -pres.
They should only contain critical bugfixes before the final release.

-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
