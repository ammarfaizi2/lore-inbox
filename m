Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424615AbWKPVKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424615AbWKPVKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424628AbWKPVKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:10:18 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:1412 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1424615AbWKPVKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:10:17 -0500
Message-ID: <62092.85.250.37.175.1163711408.squirrel@dev.mellanox.co.il>
In-Reply-To: <455CB59F.4030908@psc.edu>
References: <60157.89.139.64.58.1163542548.squirrel@dev.mellanox.co.il>
    <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
    <455CB59F.4030908@psc.edu>
Date: Thu, 16 Nov 2006 23:10:08 +0200 (IST)
Subject: Re: UDP packets loss
From: eli@dev.mellanox.co.il
To: "John Heffner" <jheffner@psc.edu>
Cc: eli@dev.mellanox.co.il, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
User-Agent: SquirrelMail/1.4.8-1.fc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> BTW, TCP will be significantly faster than UDP because with UDP you
> incur an extra full context switch on every packet.
>

Could you elaborate on this a bit more? What kind of context switch?

