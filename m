Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbUBUMak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 07:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUBUMak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 07:30:40 -0500
Received: from dns.communicationvalley.it ([212.239.58.133]:63211 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S261395AbUBUMaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 07:30:39 -0500
From: Silla Rizzoli <silla@netvalley.it>
Organization: Communication Valley spa
To: daniel.ritz@gmx.ch
Subject: Re: 2.4.25 yenta problem and small fix/workaround
Date: Sat, 21 Feb 2004 13:28:53 +0100
User-Agent: KMail/1.6
Cc: David Hinds <dhinds@sonic.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200402202331.45218.daniel.ritz@gmx.ch>
In-Reply-To: <200402202331.45218.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402211328.56826.silla@netvalley.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> silla, does this one help?
> dave, what do you think?
>
> rgds
> -daniel
>
> patch:
> the CB_CDETECT1 and CB_CDETECT2 bits both should be 0 for the card being
> recognized correctly (and one of the voltage bits need to be set)
>
Nope, sorry, same behaviour. :(

Regards,
Silla
