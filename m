Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272361AbTHEVfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272441AbTHEVfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 17:35:30 -0400
Received: from www.erfrakon.de ([193.197.159.57]:2318 "EHLO www.erfrakon.de")
	by vger.kernel.org with ESMTP id S272361AbTHEVfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 17:35:19 -0400
From: Martin Konold <martin.konold@erfrakon.de>
Organization: erfrakon
To: Rahul Karnik <rahul@genebrew.com>
Subject: Re: Interactive Usage of 2.6.0.test1 worse than 2.4.21
Date: Tue, 5 Aug 2003 23:29:40 +0200
User-Agent: KMail/kroupware-1.0.0
References: <200308050704.22684.martin.konold@erfrakon.de> <200308051452.02417.bernd-schubert@web.de> <3F2FB307.2000901@genebrew.com>
In-Reply-To: <3F2FB307.2000901@genebrew.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200308052329.40256.martin.konold@erfrakon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 5. August 2003 15:37 schrieb Rahul Karnik:

Hi,

> If disk is involved, your problem might simply be the incorrect
> readahead value. Try "hdparm -a 512".

This improved the situation noticeably while still beeing slower than 2.4.21.

I will test more recent kernels later tonight.

Regards,
-- martin

Dipl.-Phys. Martin Konold
e r f r a k o n
Erlewein, Frank, Konold & Partner - Beratende Ingenieure und Physiker
Nobelstrasse 15, 70569 Stuttgart, Germany
fon: 0711 67400963, fax: 0711 67400959
email: martin.konold@erfrakon.de


