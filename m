Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270067AbTGUNjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270074AbTGUNjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:39:21 -0400
Received: from helios.univ-reunion.fr ([194.199.73.1]:16068 "EHLO
	helios.univ-reunion.fr") by vger.kernel.org with ESMTP
	id S270067AbTGUNjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:39:20 -0400
Message-ID: <3F1BEE9C.8080605@univ-reunion.fr>
Date: Mon, 21 Jul 2003 17:46:04 +0400
From: Alain BASTIDE <alain.bastide@univ-reunion.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.2.1) Gecko/20030225
X-Accept-Language: fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Modules + 2.6.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I'm got a problem ....
	
	I compile the kernel 2.6.0 bk2 (or ac2). I install the last modutil.
	All work, i've got no warrning message or no error massage when it 
enter in init 3 .... but when i do : lsmod i see :

[root@bipbip boot]# lsmod
Module                  Size  Used by
[root@bipbip boot]# lsmod

So no modules !!!!! but i should see 3x59x ... nfsd .... lockd ....

What happens??????

