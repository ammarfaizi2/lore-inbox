Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270603AbTGNMuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 08:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270623AbTGNMhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 08:37:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53636
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S270603AbTGNMZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 08:25:53 -0400
Date: Mon, 14 Jul 2003 13:39:52 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307141239.h6ECdqXP002766@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com
Subject: -- END OF BLOCK --
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That ends the push of -ac contributions that want adding now. There is a
chunk of quota stuff that vanished with hch's merge that looks important
as it avoids deadlocks in ext3. Perhaps Christoph can take a glance at
the ext3/super differences and the related code ?

I've resynched -ac to the quota code in pre5 and added the automatic
quota loader on top again.

