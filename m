Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266209AbUHII0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266209AbUHII0W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHII0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:26:22 -0400
Received: from dsl-217-155-115-179.zen.co.uk ([217.155.115.179]:46729 "HELO
	felix.billp.org") by vger.kernel.org with SMTP id S266209AbUHII0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:26:20 -0400
From: bil@beeb.net
Reply-To: bil@beeb.net
To: Mathieu Segaud <matt@minas-morgul.org>
Subject: Re: problems with Mandrake 10.0 + kernel 2.6.8-rc2
Date: Mon, 9 Aug 2004 09:22:52 +0100
User-Agent: KMail/1.6.1
References: <200408061409.56670.bil@beeb.net> <200408061607.18040.bil@beeb.net> <871xikuw0j.fsf@barad-dur.crans.org>
In-Reply-To: <871xikuw0j.fsf@barad-dur.crans.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408090922.53196.bil@beeb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu,
On Friday 06 Aug 2004 16:27, you wrote:
> odd....
> can you try removing the umask=0 option ?
> does 'mount -t iso9660 -o ro /dev/hdc /mnt/cdrom' fail too ?
Interesting - that's fixed it. I would not have believed that that
could cause my problems. Why on earth would Mandrake put it in if
it does that!?

Thanks for the advice, 
much appreciated,
Bill
-- 
+-----------------------------------------------+
| Bill Purvis, thrice-retired software engineer |
| e-mail:  bil@beeb.net                         |
| web:     bil.members.beeb.net                 |
+-----------------------------------------------+
