Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263900AbTDYMf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263913AbTDYMf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:35:57 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:14549 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263900AbTDYMf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:35:56 -0400
Subject: Re: [RFC/PATCH] IDE Power Management try 1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>, Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0304251414430.12558-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0304251414430.12558-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051274877.560.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 14:47:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> req_type & req_subtype makes sense,
> but it is future since driver work is needed

What ? You don't want to break all drivers again ? no fun :)

Ben.

