Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTGATJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTGATJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:09:01 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20115
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262336AbTGATI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:08:59 -0400
Subject: Re: [Execve race condition] Patch ??
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Breno <brenosp@brasilsec.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000501c33fff$b82a5be0$19dfa7c8@bsb.virtua.com.br>
References: <000501c33fff$b82a5be0$19dfa7c8@bsb.virtua.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057087229.18956.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jul 2003 20:20:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-01 at 19:36, Breno wrote:
> There is a patch ?

2.4.21-ac4 has a test patch. I don't know if Linus or anyone has tackled
the bug in 2.5 yet however

