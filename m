Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbTAGPTP>; Tue, 7 Jan 2003 10:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267407AbTAGPTP>; Tue, 7 Jan 2003 10:19:15 -0500
Received: from 200-206-134-238.async.com.br ([200.206.134.238]:32390 "EHLO
	anthem.async.com.br") by vger.kernel.org with ESMTP
	id <S267409AbTAGPTO>; Tue, 7 Jan 2003 10:19:14 -0500
Date: Tue, 7 Jan 2003 13:27:43 -0200
From: Christian Reis <kiko@async.com.br>
To: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: /var/lib/nfs/sm/ files
Message-ID: <20030107132743.E2628@blackjesus.async.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

Can `anybody' (Neil, Trond?) explain what the entries in
/var/lib/nfs/sm/ are for? If they refer to file locks, can we discover
which files they are referencing so I can try and understand why we get
leftover entries in there, and in which scenarios?

I"m still trying to look into the hang problems [1] I'm getting, since
there hasn't been a lot of progress about it. Anybody have a minute free
to try and help?

[1] http://www.uwsg.iu.edu/hypermail/linux/kernel/0210.0/1112.html

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
