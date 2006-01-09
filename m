Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWAIFgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWAIFgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWAIFgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:36:11 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:24179 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751008AbWAIFgL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:36:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DVaCGNjgmph4D3o0SWdZvDvvogq/BSFalv91RcKGdmlaVfsclZbtOw83ho4pakE0jPaE4iynaZ0BKRstW2cbaI3XL6NjywNoTXLOQItDlzSNaLkxQIchnGV5jUftRjGLlnFwkAYYuq1btiY5ak5LM+g71WBVyKGYe6OVz0ZXjDo=
Message-ID: <993d182d0601082136m1cee151ayf9ffbdc8bb34c78d@mail.gmail.com>
Date: Mon, 9 Jan 2006 11:06:10 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB debug messages
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I have developed a USB host controller driver,
and at the time of development,
i had enables the USB and EHCI debug ,mesages.
Now i have removed them from the kernel configuration.

But when i insert a pendrive in the Host port, i see the Debug mesages
on the shell.


Does anybody have some idea about how to stop
these debug messages coming on shell.

Regards
conio
