Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbTBDTQj>; Tue, 4 Feb 2003 14:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTBDTQj>; Tue, 4 Feb 2003 14:16:39 -0500
Received: from fmr02.intel.com ([192.55.52.25]:44015 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267425AbTBDTQi>; Tue, 4 Feb 2003 14:16:38 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A152@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Adam Belay <ambx1@neo.rr.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: RE: PnP model
Date: Tue, 4 Feb 2003 11:25:42 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Adam Belay [mailto:ambx1@neo.rr.com] 
> In many cases, Auto configuration can be better then manual 
> configuration.
> 1.) The auto configuration engine in my patch is able to 
> resolve almost any
> resource conflict and provides the greatest chance for all 
> devices to have
> resources allocated.
> 2.) Certainly some driver developers would like to manually 
> set resources
> but many may prefer the option to auto config.

I think the people who want to manually configure their device's
resources need to step up and justify why this is really necessary.

If someone is manually configuring something, that means the automatic
config *failed*. Why did it fail? It should never fail. Manual config is
only giving the user to opportunity to get something wrong.

Regards -- Andy
