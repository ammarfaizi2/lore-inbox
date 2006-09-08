Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWIHOF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWIHOF1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 10:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWIHOF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 10:05:27 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:46608 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750786AbWIHOF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 10:05:26 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: [RFC] e-mail clients
Date: Fri, 8 Sep 2006 15:05:30 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Victor Hugo" <victor@vhugo.net>
References: <4500B2FB.8050805@vhugo.net> <9a8748490609080124q5b32d325l1c251d3e2d800f1d@mail.gmail.com> <200609081454.40522.hpj@urpla.net>
In-Reply-To: <200609081454.40522.hpj@urpla.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609081505.31000.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 September 2006 13:54, Hans-Peter Jansen wrote:
> Am Freitag, 8. September 2006 10:24 schrieb Jesper Juhl:
> > On 08/09/06, Victor Hugo <victor@vhugo.net> wrote:
> > > As I've learned--most web-clients have a hard time sending text
> > > only e-mail without
> > > wrapping every single line (not very good for patches).  Any
> > > suggestions about which client to use on lkml?? Pine?? Mutt??
> > > Thunderbird?? Telnet??
> >
> > I personally use both 'pine' and 'kmail' and they both work perfectly
> > for sending patches.
>
> With kmail, you have control over line breaks with Option -> Wrap lines,
> which is useful for e.g. pasted syslog data, but remember to enable it
> before writing the message, since you have to manually add line breaks
> for the entered text too.
>
> Inlined patches should be added via Message -> Insert File to preserve
> line breaks and white space.

Another great feature of KMail is the ability to use an external editor for 
composition, but not be forced to use it for reading emails. If you find the 
KMail composer too clumsy, you can always have it fire up vim or emacs.

Settings -> Configure KMail -> Composer -> External Editor

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
