Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135588AbRDXNFj>; Tue, 24 Apr 2001 09:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135592AbRDXNF1>; Tue, 24 Apr 2001 09:05:27 -0400
Received: from WARSL401PIP7.highway.telekom.at ([195.3.96.115]:39504 "HELO
	email04.aon.at") by vger.kernel.org with SMTP id <S135594AbRDXNEQ>;
	Tue, 24 Apr 2001 09:04:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roland Seuhs <rseuhs@aon.at>
To: <imel96@trustix.co.id>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] Single user linux
Date: Tue, 24 Apr 2001 15:03:57 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0104241917540.16169-100000@tessy.trustix.co.id>
In-Reply-To: <Pine.LNX.4.33.0104241917540.16169-100000@tessy.trustix.co.id>
MIME-Version: 1.0
Message-Id: <01042415035700.00839@server>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 24. April 2001 14:44 schrieb imel96@trustix.co.id:
> On Tue, 24 Apr 2001, Alexander Viro wrote:
> > So let him log in as root, do everything as root and be cracked
> > like a bloody moron he is. Next?
>
> come on, it's hard for me as it's hard for you. not everybody
> expect a computer to be like people here thinks how a computer
> should be.
>
> think about personal devices. something like the nokia communicator.
> a system security passwd is acceptable, but that's it. no those-
> device-user would like to know about user account, file ownership,
> etc. they just want to use it.
>
> that also explain why win95 user doesn't want to use NT. not
> because they can't afford it (belive me, here NT costs only
> us$2), but additional headache isn't acceptable.
>
> with multi-user concept, conceptually there should be an
> administrator to create account, grant permission, etc.
> no my sister doesn't want that. i bet there are billions of
> people not willing to learn how to use a computer, they just
> want to use it.
>
> and yes, mobile devices access network.

KDE2.1.1 comes with a password disabling feature. That means that you can log 
in without password (you have to use KDM). For everything else (ftp, telnet, 
ssh, text-console-login - whatever) you still need the password. 
This is very new, KDE-versions prior to 2.1.1 don't have that feature AFAIK.

So if you've got physical access to the machine you just have to click on 
your icon/name and cklick "Go!" or press Enter. It can't get much easier than 
that.

I think this is a far better alternative than a single user Linux.

Greetings,

Roland
