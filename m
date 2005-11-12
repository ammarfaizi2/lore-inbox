Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVKLWt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVKLWt6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVKLWt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:49:58 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:60115 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964875AbVKLWt5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:49:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=R+Ll2hSmjHxlp6L8VDJnp35ab1KXMswtg6tvt3wnOG7Lve1ogav2pCjp9OYr0kr72Jhe/spAz3FmHuRWC6+KcTIvxSSSPW/xx4n2FLm7sSyqFudWy/tPerkV/0wFrPaIgv4pXi+Ly5sPkW6LXza60lG3EZf6f515p8Cog97g5sc=
Message-ID: <6bffcb0e0511121449q16d24cb2g@mail.gmail.com>
Date: Sat, 12 Nov 2005 23:49:56 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: www.kernel.org/git/ - strange behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
today I have noticed some strange gitweb behaviour. Sometimes it
doesn't show any commits
(http://stud.wsi.edu.pl/~piotrowskim/files/git-web.png), but after 4-5
minutes everything is ok
(http://stud.wsi.edu.pl/~piotrowskim/files/git-web2.png). Is it a bug?
Or is it a problem with synchronisation?

Regards,
Michal Piotrowski
