Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292395AbSCDR5l>; Mon, 4 Mar 2002 12:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCDR5U>; Mon, 4 Mar 2002 12:57:20 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:36873 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292395AbSCDR5I>;
	Mon, 4 Mar 2002 12:57:08 -0500
Date: Mon, 4 Mar 2002 09:49:39 -0800
From: Greg KH <greg@kroah.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.19-pre1-ac1] usbnet frames mangled
Message-ID: <20020304174939.GB3267@kroah.com>
In-Reply-To: <1015003428.2274.5.camel@bip> <20020302071545.GB20536@kroah.com> <1015073017.777.0.camel@bip>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1015073017.777.0.camel@bip>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 04 Feb 2002 15:34:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 01:43:36PM +0100, Xavier Bestel wrote:
> le sam 02-03-2002 à 08:15, Greg KH a écrit :
> > On Fri, Mar 01, 2002 at 06:23:48PM +0100, Xavier Bestel wrote:
> > > 
> > > which of course doesn't mean anything. I saw this behavior since I
> > > upgraded my desktop from 2.4.18-ac2 to 2.4.19-pre1-ac1
> > 
> > So you kept your USB client at the same version, but your host changed
> > versions?  And 2.4.18-ac2 works, but 2.4.19-pre1-ac1 doesn't?
> 
> That's it.
> 
> > Can you see if 2.4.19-pre2 works or not for you?
> 
> It works pretty well.

So you don't have a problem with 2.4.19-pre2?  Great :)

thanks,

greg k-h
