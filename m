Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWIHMy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWIHMy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWIHMy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:54:59 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:62444 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750961AbWIHMy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:54:58 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] e-mail clients
Date: Fri, 8 Sep 2006 14:54:39 +0200
User-Agent: KMail/1.9.4
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>, "Victor Hugo" <victor@vhugo.net>
References: <4500B2FB.8050805@vhugo.net> <9a8748490609080124q5b32d325l1c251d3e2d800f1d@mail.gmail.com>
In-Reply-To: <9a8748490609080124q5b32d325l1c251d3e2d800f1d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609081454.40522.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. September 2006 10:24 schrieb Jesper Juhl:
> On 08/09/06, Victor Hugo <victor@vhugo.net> wrote:
> > As I've learned--most web-clients have a hard time sending text
> > only e-mail without
> > wrapping every single line (not very good for patches).  Any
> > suggestions about which client to use on lkml?? Pine?? Mutt??
> > Thunderbird?? Telnet??
>
> I personally use both 'pine' and 'kmail' and they both work perfectly
> for sending patches.

With kmail, you have control over line breaks with Option -> Wrap lines, 
which is useful for e.g. pasted syslog data, but remember to enable it 
before writing the message, since you have to manually add line breaks 
for the entered text too.

Inlined patches should be added via Message -> Insert File to preserve 
line breaks and white space.

Pete
