Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVF0RQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVF0RQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 13:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVF0RNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 13:13:11 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:38721 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261557AbVF0RIS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 13:08:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=awxviG/TSDG0SIIx52sKQ8zi377uG1VYV3AsqQOMohh/2sopzkvjFGNOtmpKEzXuJ0DK8kcvJlhT16oX5Hl308AjXxXfiAlnX+vvvwDQ9uvxQ1BR9WNjFsz5oNST0D7dvc0koxDQXiTc0IYT6jh2GKuJMlMXPSWYphPbxEySq4U=
Message-ID: <4fec73ca05062710082e273097@mail.gmail.com>
Date: Mon, 27 Jun 2005 19:08:08 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Reply-To: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Documentation about the Virtual File-System
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the first time I post to this mailing list.

I am working with the Computer Architecture department of my
University (Carlos III of Madrid, Spain). I have to adapt an existing
(distributed) filesystem to the Linux kernel. Therefore, I am looking
for the interfaces in the Virtual File-System.

I do not know if this is the correct mailing list to post to about
this topic. If not, please, tell me.

I have read some documentation, but I have not found any reference to
the 2.6 kernel:
    - http://www.linux.it/~rubini/docs/vfs/vfs.html
    - http://www.faqs.org/docs/kernel_2_4/lki.html#toc3
    - http://www.cse.unsw.edu.au/~neilb/oss/linux-commentary/vfs.html

I cannot determine if this references are up-to-date, because I have
not started coding yet. In case they are not, do anyone knows about
newer references?

Is there any "Building a File system HOWTO"?

Thanks in advance,

Regards,

-- 
Guillermo
