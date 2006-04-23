Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWDWVpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWDWVpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 17:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWDWVpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 17:45:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:6688 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932070AbWDWVpc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 17:45:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=luxEd9zMr3nxBHV5qjDGdJBWwE5bjZ5FiSHFQt/0u1kv5/MIRAN0q6BYDfu6caAk98NNwq1IQW2eLEM8/G/w1UozWkrBorWiw3narzl6EmGJDlZZBI/uc4p9jrS/g/tbIw9saPIhSusZle2EvyD8GG9oCWpmHnrdZ9pzGSUoJiU=
Message-ID: <5a4c581d0604231445l209fc672gb132dab8be97c337@mail.gmail.com>
Date: Sun, 23 Apr 2006 23:45:32 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: [2.6.17-rc2-git5] CIFS_SessSetup undefined in cifs.ko
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
System.map  2.6.17-rc2-git5; fi
WARNING: /lib/modules/2.6.17-rc2-git5/kernel/fs/cifs/cifs.ko needs
unknown symbol CIFS_SessSetup

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
