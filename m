Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbTHTHjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTHTHjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:39:13 -0400
Received: from gonzo.one-2-one.net ([217.115.142.69]:56082 "EHLO
	gonzo.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261729AbTHTHjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:39:12 -0400
Date: Wed, 20 Aug 2003 09:38:55 +0200
From: stefan.eletzhofer@eletztrick.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Console on USB
Message-ID: <20030820073855.GU10622@gonzo.local>
Reply-To: stefan.eletzhofer@eletztrick.de
Mail-Followup-To: stefan.eletzhofer@eletztrick.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain>
User-Agent: Mutt/1.3.27i
Organization: Eletztrick Computing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
AFAIK there was a network console patch on the list recently.

IIRC it sends UDP packets to a receiving daemon (or netcat ;),
and works w/o interrupts. I believe, though, that there are
only certain nics supported.

Cheers,
	Stefan E.
-- 
Eletztrick Computing - Customized Linux Development
Stefan Eletzhofer, Marktstrasse 43, DE-88214 Ravensburg
http://www.eletztrick.de
