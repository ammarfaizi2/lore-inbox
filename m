Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263920AbTJEWGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTJEWGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:06:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:47076 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263920AbTJEWG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:06:27 -0400
X-Authenticated: #1033915
Message-ID: <3F8090E7.9040501@GMX.li>
Date: Sun, 05 Oct 2003 23:45:11 +0200
From: Jan Schubert <Jan.Schubert@GMX.li>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031005
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kernelnewbies@vger.kernel.org
Subject: Q: Maintainer for drivers/isdn/hisax in kernel-2.6
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who is the Maintainer for the (old) ISDN-Hisax-Part for the kernel-2.6 
(located in drivers/isdn/hisax)? I've digged into the code and got some 
problems. IMHO there exist some old/outdated code which will never be 
used in the current state (there are some Kernel-Config-Values which are 
not defined or which will never be used). I tried to write an module to 
get an Teles ISDN-PCMCIA Card running and run into some problems which 
prevents me from further testing now.

Any help?
Thx, Jan

PS: May someone point me to an Kernel-Module-Howto for kernel-2.6? There 
is none in the the Documentation-Directory and i did'nt found one in the 
net for now....

