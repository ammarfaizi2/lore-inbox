Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVA3PHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVA3PHn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 10:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVA3PHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 10:07:43 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:12591 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261710AbVA3PHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 10:07:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PIjI3KbUYkNDFaGkWy1Az7cQqbXGtCD3KYXSL7sAlGYi+CWDf0cB1riGD47oDoZ/FNjc+iXjx/msi0ASpQeFgr6LlwbJJti+ug9X/bSH5g+JRffBCxtmDoY+K5m8QKKNTxZWcTAe4E3xd7e/b8v+oiyixpScbsrzZIpXMa19IL8=
Message-ID: <9e47339105013007075ea110c2@mail.gmail.com>
Date: Sun, 30 Jan 2005 10:07:35 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search result
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <21d7e9970501300322ffdabe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <fa.ks44mbo.ljgao4@ifi.uio.no> <fa.hinb9iv.s38127@ifi.uio.no>
	 <41F21FA4.1040304@pD9F8757A.dip0.t-ipconnect.de>
	 <21d7e99705012205012c95665@mail.gmail.com> <41F76B4D.8090905@hist.no>
	 <20050130111634.GA9269@hh.idb.hist.no>
	 <21d7e9970501300322ffdabe0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't PCI:0:8:0 have to be on a PCI bus? AGP would look like
PCI:1:0:0 or PCI:2:0:0.

-- 
Jon Smirl
jonsmirl@gmail.com
