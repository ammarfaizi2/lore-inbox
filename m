Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUKWViT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUKWViT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbUKWVfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 16:35:38 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:59509 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261351AbUKWVel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 16:34:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=OQPYuvQLK2kEGRL48dkKMmQ9qEgOuwpjfR/YI9m/I6CxuLgxb+j04/Fu0UX97piSDPDDMlc1lAa6TMl2x8ArvBM1IJrPh7y908Xf/zkY++YiZh213N/kfyaO2hLp44BIpmKx/pymhnNCkCW4X4t6jB4FNqd7eck+j42seWooQh4=
Message-ID: <432beae04112313344fb4a5f9@mail.gmail.com>
Date: Tue, 23 Nov 2004 13:34:38 -0800
From: Justin Patrin <papercrane@gmail.com>
Reply-To: papercrane@reversefold.com
To: linux-kernel@vger.kernel.org
Subject: Compact Flash - simulating a card
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not currently subscribed to this list as I figure I'll be shunted
to another anyway. Please CC me on replies to this thread. If I should
be asking "someone else" whether it be another list or group, let me
know.

I currently have a Sharp Zaurus with OpenZaurus on it. I'm trying to
connect a device to the CF slot. Would is be possible to fake the CF
"startup"? I.e. connect a dumb device (which does not understand the
CF spec itself) but have the kernel able to pass certain requests on
to it? I have tried connecting the device and it sees it (as I've
hooked up the detection pins) but something times out. Sorry, I don't
have the exact message at the moment.

-- 
Justin Patrin
