Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161097AbWBTSL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161097AbWBTSL0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 13:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWBTSL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 13:11:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:150 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161100AbWBTSLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 13:11:24 -0500
Subject: Re: Areca RAID driver remaining items?
From: Arjan van de Ven <arjan@infradead.org>
To: Dax Kelson <dax@gurulabs.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       billion.wu@areca.com.tw, alan@lxorguk.ukuu.org.uk, akpm@osdl.org,
       erich@areca.com.tw, oliver@neukum.org
In-Reply-To: <1140458552.3495.26.camel@mentorng.gurulabs.com>
References: <1140458552.3495.26.camel@mentorng.gurulabs.com>
Content-Type: text/plain
Date: Mon, 20 Feb 2006 19:11:19 +0100
Message-Id: <1140459079.2979.70.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "There's lots of architectural problems.  It's doing it's own queueing,
> it's stuffing kernel structures into memory on the hardware and so on.
> Basically someone knowledgeable about the hardware needs to start from
> scratch on it."
> 
> What are the show stoppers that prevents a merge into the Linus tree?

own queueing for sure is a show stopper; 
stuffing kernel structures into the hw is also very much evil


