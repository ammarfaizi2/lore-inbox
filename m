Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267333AbTA1OmG>; Tue, 28 Jan 2003 09:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTA1OmG>; Tue, 28 Jan 2003 09:42:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34177
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S267333AbTA1OmF>; Tue, 28 Jan 2003 09:42:05 -0500
Subject: Re: Bootscreen
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stefan Reinauer <stepan@suse.de>
Cc: Raphael Schmid <raphael@arrivingarrow.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128121048.GB32488@suse.de>
References: <398E93A81CC5D311901600A0C9F2928946936D@cubuss2>
	 <20030128121048.GB32488@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043765442.8675.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 28 Jan 2003 14:50:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 12:10, Stefan Reinauer wrote:
> It's not too much to even state that almost any computer working with
> Linux 2.4+ can do 800x600 or 1024x768. Anything below that can be
> considered a special case, regarding the numbers out there. But that
> does not influence the possibility of using a bootsplash graphics. 
> On a system you can't use it properly, you probably also would not 
> want it (i.e. use normal text mode boot instead of a framebuffer
> driver)

Lots of systems cannot do 800x600 or 1024x768. Some of them cannot
do 640x480 very well but 640x480 is safe except for weird kit because
of the VGA mode support.


