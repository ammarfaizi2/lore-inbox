Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWFMKAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWFMKAx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 06:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWFMKAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 06:00:52 -0400
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:30654 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750773AbWFMKAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 06:00:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kGuqetbFWlemviruyhERKkJOHWGcpnbrQa/PuehgpeQXbtWKyadZQDWSuQqZdVGECYIN5E4H0h9m3bigDYAUItMSVRqHf5tWr2ixq5gOQhHQCEJ+Bu+AyrOx97WyKfHX9bOye7m0sTkcNK2RcYrfm9Spl81CbpFgN3tYdmQ5yNI=  ;
Message-ID: <20060613100050.31066.qmail@web26913.mail.ukl.yahoo.com>
Date: Tue, 13 Jun 2006 12:00:50 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org
In-Reply-To: <1149873734.22124.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> If I hack the OS I write a new boot block which locks the disk then reboot into it.

 Another solution to be safe, because you need a full power cycle of the HD,
 is to keep the HDs on a separate non interruptible power supply (not stoppable
 by APM/ACPI).

__________________________________________________
Do You Yahoo!?
En finir avec le spam? Yahoo! Mail vous offre la meilleure protection possible contre les messages non sollicités 
http://mail.yahoo.fr Yahoo! Mail 
