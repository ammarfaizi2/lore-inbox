Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVAQNL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVAQNL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 08:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbVAQNL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 08:11:58 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:7458 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262791AbVAQNL5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 08:11:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=pKmdTungq0XHu1yJsTJQEXY2vb+t38X83GMi5OOVnBZA7Mdf6yX+fFmXeUj74eO2e+M/PUIBdjkrb3tTpy2eciDXqrurOvQlrSaaAkLM1ShObJ5dqt3W1+JklCDoNSLxjdu9o+1YnPk6+pZL2vfdzznzFxoWDctnGMTEww3+NdM=
Date: Mon, 17 Jan 2005 14:11:50 +0100
From: Diego Calleja <diegocg@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Audit Project?
Message-Id: <20050117141150.7cce80c1.diegocg@gmail.com>
In-Reply-To: <41EB6BD6.5070702@comcast.net>
References: <41EB6691.10905@comcast.net>
	<41EB6BD6.5070702@comcast.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 17 Jan 2005 02:40:06 -0500 John Richard Moser <nigelenki@comcast.net> escribió:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On the same line, I've been graphing Ubuntu Linux Security Notices for a
> while.  I've noticed that in the last 5, the number of kernel-related
> vulnerabilities has doubled (3 more).  This disturbs me.


Most of the latest (ie: 2004) serious kernel holes (if not all) have been
found by the isec.pl guys (http://www.isec.pl/vulnerabilities.html), specially
Paul Starzetz. While they're not a "auditing project", the effect they're
having is the same.


(By the way, secunia reports that 48% of the vulnerabilities reported for
the linux kernel are not patched http://secunia.com/product/2719/ . I guess
they can't notice when bugs are fixed but I hope there's not any open hole
left)
