Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTLAO0t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTLAO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:26:49 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:4214 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263711AbTLAO0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:26:48 -0500
Date: Mon, 1 Dec 2003 11:24:28 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: hadmut@danisch.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partitions on a loopback block device?
Message-Id: <20031201112428.3e92ce2c.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20031201124034.GA32127@danisch.de>
References: <20031201124034.GA32127@danisch.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Dec 2003 13:40:34 +0100, hadmut@danisch.de wrote:
>Would it be possible to have a loopback blockdevice recognize
>partition tables and to provide partitions as any other block device?
>
>Obviously, naming is not very elegant, but /dev/loopa0 would be a nice
>analogon to /dev/hda0 and /dev/sda0

Hi,

try this patch.

ftp://ftp.hq.nasa.gov/pub/ig/ccd/enhanced_loopback/patches

>
>regards
>Hadmut

chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
