Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVHZLP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVHZLP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 07:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVHZLPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 07:15:25 -0400
Received: from mail.charite.de ([160.45.207.131]:16540 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932562AbVHZLPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 07:15:25 -0400
Date: Fri, 26 Aug 2005 13:15:21 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: List linux-kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Karel Zak <kzak@redhat.com>,
       Christophe Saout <christophe@saout.de>, Adrian Bunk <bunk@stusta.de>
Subject: Re: util-linux: cryptsetup support
Message-ID: <20050826111521.GT31003@charite.de>
Mail-Followup-To: List linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Karel Zak <kzak@redhat.com>,
	Christophe Saout <christophe@saout.de>,
	Adrian Bunk <bunk@stusta.de>
References: <1125054020.17511.20.camel@petra> <20050826111307.GA2877@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050826111307.GA2877@infradead.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christoph Hellwig <hch@infradead.org>:

> > It's the place where you can found util-linux patch that adds full
> > cryptsetup-luks support to mount, umount, swapon and swapoff. The patch
> > supports classic cryptsetup and LUKS extension too.
> 
> What is LUKS?

LUKS - Linux Unified Key Setup
http://luks.endorphin.org/

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
