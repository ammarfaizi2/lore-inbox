Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269373AbUJRELB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269373AbUJRELB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 00:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269381AbUJRELB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 00:11:01 -0400
Received: from smtp-26.ig.com.br ([200.226.132.160]:27835 "HELO
	smtp-26.ig.com.br") by vger.kernel.org with SMTP id S269373AbUJRELA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 00:11:00 -0400
Message-ID: <41733238.4010409@ig.com.br>
Date: Mon, 18 Oct 2004 01:02:16 -0200
From: "Olavo B D'Antonio" <olavobdantonio@ig.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Framebuffer problem.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   
    I changed my GeForce FX 5200 128MB to  another GeForce FX5200 but 
with 256MB of memory, and something had been wrong. At boot, framebuffer 
return a error:
    vesafb: probe of vesafb0 failed with error -6

I found another one with same error.
The old card was AGP revision 2.0, this new card is AGP revision 3.0.

Is framebuffer incompatible with this review?

Regards,
    Olavo.
