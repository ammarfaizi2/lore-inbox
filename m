Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266273AbUITLjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266273AbUITLjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUITLjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:39:49 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:59026 "EHLO
	mwinf0106.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266273AbUITLjq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:39:46 -0400
Subject: Re: OOM & [OT] util-linux-2.12e
From: Xavier Bestel <xavier.bestel@free.fr>
To: DervishD <lkml@dervishd.net>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20040920110631.GJ5482@DervishD>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl>
	 <20040920110631.GJ5482@DervishD>
Content-Type: text/plain; charset=utf-8
Message-Id: <1095680326.27965.238.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Sep 2004 13:38:46 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 20/09/2004 à 13:06, DervishD a écrit :
> does the kernel *read* /proc/mounts contents?

/proc/mounts is kernel-generated on the fly (it's alive only during the
read() call).

	Xav

