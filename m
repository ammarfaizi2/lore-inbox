Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbUL3EKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbUL3EKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 23:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUL3EKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 23:10:06 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:21899 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261341AbUL3EKB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 23:10:01 -0500
Date: Thu, 30 Dec 2004 02:10:13 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Diego <foxdemon@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: POSIX ACL's with NFS (was: Re: About NFS4 in kernel 2.6.9)
Message-ID: <20041230041013.GB9288@ime.usp.br>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Diego <foxdemon@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <d5a95e6d04122712148459507@mail.gmail.com> <41D368F7.8090502@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41D368F7.8090502@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2004 20:46:38 +0100 (MET), Jan Engelhardt
<jengelh@linux01.gwdg.de> wrote:
>config NFS_FS
>      tristate "NFS file system support"
>      depends on INET
>      select LOCKD
>      select SUNRPC
>      select NFS_ACL_SUPPORT if NFS_ACL

Are you using any external patches for getting ACL support in NFS? I'd de
highly interested in those. I already tried googling but nothing
enligtening was found apart from the http://acl.bestbits.at/ site. :-/


Thanks for any pointers, Rogério Brito.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
