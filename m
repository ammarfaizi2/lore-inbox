Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270980AbTHHMng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 08:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271182AbTHHMng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 08:43:36 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:46727 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270980AbTHHMnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 08:43:32 -0400
Subject: Re: 2.4.22-rc1 FIFO bug still present
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Stephen C. Tweedie" <sct@redhat.com>
In-Reply-To: <20030806192306.6085b3e0.robn@verdi.et.tudelft.nl>
References: <20030806192306.6085b3e0.robn@verdi.et.tudelft.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060346384.4933.34.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Aug 2003 13:39:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-06 at 18:23, Rob van Nieuwkerk wrote:
> Stephen C. Tweedie made a fix (see below) for it in May.
> It has been in the Alan's -ac series since then and it works fine.

Certainly seems to be fine and it is a real bug. There is another unfixed
one of the same form with tty drivers too

