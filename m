Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSHDFEe>; Sun, 4 Aug 2002 01:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318100AbSHDFEe>; Sun, 4 Aug 2002 01:04:34 -0400
Received: from webmail9.rediffmail.com ([202.54.124.178]:18356 "HELO
	webmail9.rediffmail.com") by vger.kernel.org with SMTP
	id <S318097AbSHDFEe>; Sun, 4 Aug 2002 01:04:34 -0400
Date: 4 Aug 2002 05:07:40 -0000
Message-ID: <20020804050740.5833.qmail@webmail9.rediffmail.com>
MIME-Version: 1.0
From: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>
Reply-To: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>
To: "Brad Hards" <bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, "Greg KH" <greg@kroah.com>
Subject: Re: Re: installation of latest kernel on compaq notebook
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanx Hards,
It worked.
Regards
Venku.

On Sat, 03 Aug 2002 Brad Hards wrote :
>On Sat, 3 Aug 2002 15:09, Enugala Venkata Ramana wrote:
> > Hi ,
> > Using the make xconfig. i cannot even select it.
>I assume that you can select other options, but not
>this particular option (Hint: you could have told me that).
>
>I take it that you didn't look at the options that this
>option depends on, and you need to turn on the
>configuration options for CONFIG_EXPERIMENTAL
>and possibly CONFIG_NET
>
>Brad
>--
>http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds 
>in Black.
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  
>http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

