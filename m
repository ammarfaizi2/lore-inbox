Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWIHQGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWIHQGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWIHQGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:06:54 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:55813 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1750827AbWIHQGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:06:53 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [RFC] e-mail clients
Date: Fri, 8 Sep 2006 18:06:49 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <4500B2FB.8050805@vhugo.net> <200609081454.40522.hpj@urpla.net> <200609080918.47693.gene.heskett@verizon.net>
In-Reply-To: <200609080918.47693.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609081806.50087.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 September 2006 15:18, Gene Heskett wrote:
> On Friday 08 September 2006 08:54, Hans-Peter Jansen wrote:
> >Am Freitag, 8. September 2006 10:24 schrieb Jesper Juhl:
> >> On 08/09/06, Victor Hugo <victor@vhugo.net> wrote:
> >> > As I've learned--most web-clients have a hard time sending text
> >> > only e-mail without
> >> > wrapping every single line (not very good for patches).  Any
> >> > suggestions about which client to use on lkml?? Pine?? Mutt??
> >> > Thunderbird?? Telnet??
> >>
> >> I personally use both 'pine' and 'kmail' and they both work perfectly
> >> for sending patches.
> >
> >With kmail, you have control over line breaks with Option -> Wrap lines,
> >which is useful for e.g. pasted syslog data, but remember to enable it
> >before writing the message, since you have to manually add line breaks
> >for the entered text too.
> >
> >Inlined patches should be added via Message -> Insert File to preserve
> >line breaks and white space.
>
> But be sure and turn word wrapping off before inserting the file, or
> pasting (usually bad I might add).  And my version of kmail wraps the
> whole document if the wrapping is turned back on, as it is now.  Which
> makes it rather frustrating.

To workaround this, I first type the message with wordwrapping on, then close 
the message window and let it save the message to Drafts. Then repoen the 
message from Drafts, turn off wordwrap and insert the patch using 
Message->Insert File. It's not great but still better than Thunderbird.

>
> >Pete
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ondrej Zary
