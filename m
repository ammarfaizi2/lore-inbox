Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272690AbTHEMAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272691AbTHEMAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:00:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S272690AbTHEMAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:00:49 -0400
Date: Tue, 5 Aug 2003 07:00:40 -0500
From: Tommy Reynolds <reynolds@redhat.com>
To: rafael@thinkfreak.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module Programming
Message-Id: <20030805070040.7d66b652.reynolds@redhat.com>
In-Reply-To: <200308050838.49544.rafael@thinkfreak.com.br>
References: <200308050838.49544.rafael@thinkfreak.com.br>
Organization: Red Hat GLS
X-Mailer: Sylpheed version 0.9.4cvs1 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$
 t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl
 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
X-Message-Flag: Outlook Virus Warning: Reboot within 12 seconds or risk loss
 of all files and data!
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uttered Rafael Costa dos Santos <rafael@thinkfreak.com.br>, spoke thus:

> Where can I follow the modifications under the main functions of linux kernel 
> programming between versions of kernerl?
> 
> I am asking that because I have some work on that area and I want it to be 
> portable to every kernel versions.

The authoritative reference for Linux device drivers is Rubini and
Corbet's book "Linux Device Drivers".  You should buy your own copy
but there is an online copy available:

	http://www.xml.com/search/index.ncsp?sp-q=rubini&search=search

Linux device drivers are not guaranteed to be portable between kernel
versions, however they are usually platform-independent.

Cheers!
