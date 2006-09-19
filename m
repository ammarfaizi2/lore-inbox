Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWISF7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWISF7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 01:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWISF7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 01:59:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:29600 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932190AbWISF7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 01:59:13 -0400
Message-ID: <450F872F.2010200@pobox.com>
Date: Tue, 19 Sep 2006 01:59:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata: improve handling of diagostic fail (and hardware
 that misreports it)
References: <1158076512.6780.41.camel@localhost.localdomain>
In-Reply-To: <1158076512.6780.41.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reviewed, and applied after fixing Alan-isms :)

