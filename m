Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273463AbRIUMLF>; Fri, 21 Sep 2001 08:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273467AbRIUMK4>; Fri, 21 Sep 2001 08:10:56 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:54031 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S273463AbRIUMKk>; Fri, 21 Sep 2001 08:10:40 -0400
Date: Fri, 21 Sep 2001 13:11:02 +0100
From: Bob Dunlop <Bob.Dunlop@farsite.co.uk>
To: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Cc: "Daniela P. R. Magri Squassoni" <daniela@cyclades.com>,
        linux-kernel@vger.kernel.org
Subject: Re: New generic HDLC available
Message-ID: <20010921131102.A8631@farsite.co.uk>
In-Reply-To: <m3bsoumbtv.fsf@intrepid.pm.waw.pl> <3BAA0465.C02DFEB7@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAA0465.C02DFEB7@cyclades.com>; from daniela@cyclades.com on Thu, Sep 20, 2001 at 04:27:52PM +0100
Organization: FarSite Communications Ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20,  Daniela P. R. Magri Squassoni wrote:
> Hi,
> 
> Are there any news about the inclusion of these changes in the kernel?
...

I'd like to second the query.  It's additional work I'd rather avoid to
have to track two versions.



> Krzysztof Halasa wrote:
...
> > The patch has been generated against 2.4.4-ac6 tree. It should apply to
> > pure 2.4.4 as well. Protocol support is now split into separate files
> > hdlc_fr.c, hdlc_cisco.c etc.
...

Patches don't work with 2.4.9-ac series kernels.
I've put an updated version against 2.4.9-ac10 in
http://www.xyzzy.org.uk/farsync/hdlc-2.4.9-ac10.patch.gz
if you'd like to grab that.

I notice you include patches for existing kernel drivers and since the
farsync driver is now in the 2.4.9 kernel would you like me to supply
you with patches for that ?

-- 
        Bob Dunlop
        FarSite Communications Ltd.
        http://www.farsite.co.uk/
