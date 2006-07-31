Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWGaMD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWGaMD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 08:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWGaMD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 08:03:29 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:8680 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750812AbWGaMD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 08:03:28 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17613.61542.441990.620222@gargle.gargle.HOWL>
Date: Mon, 31 Jul 2006 15:58:30 +0400
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion)
Newsgroups: gmane.comp.file-systems.reiserfs.general,gmane.linux.kernel
In-Reply-To: <44CBE7FF.2030109@namesys.com>
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl>
	<44CA31D2.70203@slaphack.com>
	<Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
	<44C9FB93.9040201@namesys.com>
	<44CA6905.4050002@slaphack.com>
	<44CA126C.7050403@namesys.com>
	<44CA8771.1040708@slaphack.com>
	<44CABB87.3050509@namesys.com>
	<17611.21640.208153.492074@gargle.gargle.HOWL>
	<44CBE7FF.2030109@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
X-SystemSpamProbe: GOOD 0.0000033 18950cef32fadf8e4908ede07fa16567
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
 > Nikita Danilov wrote:

[...]

 > >
 > >As you see, ext2 code already has multiple file "plugins", with
 > >persistent "plugin id" (stored in i_mode field of on-disk struct
 > >ext2_inode).
 > >
 > >Nikita.
 > >
 > >
 > So the job is already done.  Good.  Reiser4 can be included then.:) 

Indeed, namesys already implemented requirements pointed to by Christoph
Hellwig, as far as meta-data plugins are concerned, so this issue is not
an obstacle.

 > 
 > Hans "The Easily Agreeable" Reiser
 > 

PS: please, don't trim CC lists.

Nikita.

