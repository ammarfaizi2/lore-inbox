Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVEUDpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVEUDpr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 23:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVEUDpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 23:45:46 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:60841 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261653AbVEUDpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 23:45:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=qP1JX5Y/iv3Gxur3R0TOd6nFKShAu84w7Rxo1j/8k7bZGskSaBJJpd9WCmGBjuj8hLbLu6LS2q0UKiUgOEcsTWI8BzI8wBl+OGlnOD2HwVZIgbf+j7MzDhzYyDuZoP1KXSA//YcSIx4NJZPrpXn7G6aNqYOk7wVMX3yjEMultzw=
Date: Sat, 21 May 2005 12:45:38 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] kprobes-HERE! 20050521
Message-ID: <20050521034538.GA5999@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello guys.

 --regs option is added to kphere, which calls show_registers(), so
now you can dump register contents + contents in the top of the stack.

 http://home-tj.org/kphere/files/kphere-20050521.tar.gz

 For more info.

 http://home-tj.org/kphere/

 Thanks.

-- 
tejun
