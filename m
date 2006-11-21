Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755488AbWKUXag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488AbWKUXag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 18:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbWKUXag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 18:30:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:7001 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755478AbWKUXaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 18:30:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=alI0spfHFsYTWu2gTxVqj4TgF9ziA9ugn/CZgbHCAv+i7WvwnQYkt0fZRxYoa/bNyQggwAoQxtfY6Do6w+LhID6gwkAHFOs6FJQkiByXTJ2I04owvqQkCiLOHRONg9f9LiQYfLuoz7yJtt0t6Jyryyt5ERR9Rq5evh6RiJYOUCc=
Message-ID: <6d4bc9fc0611211530te8b9b6m84860c7aacdd1b01@mail.gmail.com>
Date: Wed, 22 Nov 2006 00:30:33 +0100
From: "Maarten Maathuis" <madman2003@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: A curious user would like to know what anonpages are.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently i noticed an (in my eyes) unexplainable memory loss, I
couldn't trace it a specific process, the slab, buffers or any of the
usual places.

cat /proc/meminfo revealed something called anonpages, which seemed to
be around a 100 MiB large.

I have no idea what they are, searching the mailinglist archives or
using a conventional search engine didn't yield anything usefull.

Can anyone enlighten a curious user?

Sincerely,

Maarten Maathuis.

PS: Please CC me any replies, thank you.
