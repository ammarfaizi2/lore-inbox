Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTFPR2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTFPR2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:28:10 -0400
Received: from [198.182.60.75] ([198.182.60.75]:13703 "EHLO vaxjo.synopsys.com")
	by vger.kernel.org with ESMTP id S264066AbTFPR2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:28:08 -0400
Message-ID: <3EEE015A.8080601@Synopsys.COM>
Date: Mon, 16 Jun 2003 19:41:46 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030613
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.71, fbconsole: No boot logo?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I haven't played with 2.5.x kernels for quite some time, so
maybe I missed something, but shouldn't there be a penguin
logo at boot time? AFAICT I have enabled vesa framebuffer,
fbconsole, and a 224 colors boot logo. The first few lines
are not scrolled at boot time, but Tux is gone.

On kernel 2.4.21 Tux is back.


Regards

Harri

