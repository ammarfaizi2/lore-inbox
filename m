Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTFFQrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTFFQrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:47:11 -0400
Received: from maser.urz.unibas.ch ([131.152.1.5]:24338 "EHLO
	maser.urz.unibas.ch") by vger.kernel.org with ESMTP id S262018AbTFFQrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:47:10 -0400
Date: Fri, 06 Jun 2003 19:03:40 +0200
From: Arsene Gschwind <arsene.gschwind@unibas.ch>
Subject: Re: PERC4-DI?
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Message-id: <3EE0C96C.6070302@unibas.ch>
Organization: Universitaet Basel
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en, de-ch, fr-fr, en-us
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
References: <20030606163717.GK8594@rdlg.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that you're talking about a Dell server. So far I know PERC 
means PowerEdge Enhanced Raid Controller or something similar.
Under the PERC you will find diff. Raid ctrl (Adaptec maybe Mylex) you 
may need to check wich kind of Raid Ctrl it is.
One for sure PERC isn't a RAID Ctrl supplier.

Arsène

Robert L. Harris wrote:

>My company is looking at buying some machines with "PERC4-DI" SCSI RAID
>controllers.  Poking around the .config file I'm not finding anything
>related to this.  Anyone know off the top of their heads what driver
>would be used for this controller, any known catastrophic bugs, etc?
>
>Thanks,
>  Robert
>
>
>:wq!
>---------------------------------------------------------------------------
>Robert L. Harris                     | GPG Key ID: E344DA3B
>                                         @ x-hkp://pgp.mit.edu 
>DISCLAIMER:
>      These are MY OPINIONS ALONE.  I speak for no-one else.
>
>Diagnosis: witzelsucht  	
>
>IPv6 = robert@ipv6.rdlg.net	http://ipv6.rdlg.net
>IPv4 = robert@mail.rdlg.net	http://www.rdlg.net
>  
>

-- 
***********************************************************
Gschwind Arsene			
Universitaet Rechenzentrum (URZ)
Klingelbergstrasse 70
CH-4056 Basel
SWITZERLAND

Languages : F/E/D
WWW:  <http://www.unibas.ch/urz>
Mail: <Arsene.Gschwind@unibas.ch>
************************************************************
*********



