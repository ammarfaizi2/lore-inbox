Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUKABfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUKABfA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 20:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUKABfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 20:35:00 -0500
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:30808 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261502AbUKABev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 20:34:51 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: ipw2100-devel@lists.sourceforge.net
Subject: Re: [Ipw2100-devel] Re: [2.6.10-rc1-mm2] Firmware loader gone bogus?
Date: Sun, 31 Oct 2004 21:34:46 -0500
User-Agent: KMail/1.7
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org,
       smiler@lanil.mine.nu
References: <200410311627.02116.shawn.starr@rogers.com> <200411010134.19922.oliver@neukum.org> <200410312050.48975.shawn.starr@rogers.com>
In-Reply-To: <200410312050.48975.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410312134.46587.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See: http://marc.theaimsgroup.com/?l=linux-kernel&m=109919609211671&w=2

This will appear in the next -bk automated snapshot soon.

That should fix everyone's firmware load failures.

Shawn.

On October 31, 2004 20:50, Shawn Starr wrote:
> 0.0.20040329-1 Linux Hotplug Scripts
>
> hotplug_20040329 from Debian unstable/testing.
>
> Using 2.6.9-rc4-xx I had no problems with loading the firmware. As in my
> previous emails on the subject, I posted some debug that from the firmware
> module and kobject_hotplug, and from there I couldn't see why it was
> failing.
>
> I know lots of changes have been made to hotplug in the kernel recently.
>
> Shawn.
>
> On October 31, 2004 19:34, Oliver Neukum wrote:
> > Am Sonntag, 31. Oktober 2004 22:27 schrieb Shawn Starr:
> > > Yeah I noticed my ipw2200 firmware broke in 2.6.10-rc1-bk5
> > >
> > > Does 2.6.10-rc1 non-bk snapshots work for you?
> >
> > Which script do you use to load the firmware?
> >
> >  Regards
> >   Oliver
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> ipw2100-devel mailing list
> ipw2100-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ipw2100-devel
