Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTDPWWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 18:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTDPWWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 18:22:50 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:49784 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261665AbTDPWWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 18:22:47 -0400
Date: Thu, 17 Apr 2003 00:34:18 +0200 (CEST)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre7 - aic79xx
In-Reply-To: <Pine.LNX.4.44.0304161543100.22459-100000@petra.hos.u-szeged.hu>
Message-ID: <Pine.LNX.4.53.0304170027280.4298@lt.wsisiz.edu.pl>
References: <Pine.LNX.4.44.0304161543100.22459-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, Geller Sandor wrote:

> I don't use the aic79xx driver in the -ac tree. In another thread, 1 or 2
> weeks ago Justin Gibbs stated, that his latest drivers are the most
> stable. I'm using an Intel 7501VW2 motherboard in a production server, so
> I don't want to test drivers, which can cause filesystem corruption. Maybe
> Lukasz can test with noapic - I suggest Justin's drivers, and if the
> problem still exists, test with the 'noapic' boot parameter, and track
> down the problem. Regards,

Well, I'm using it also in a production server. I can't test it.
My problem activating, when process updatedb running on big home 
area.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
