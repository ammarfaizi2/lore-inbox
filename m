Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVKUOTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVKUOTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 09:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVKUOTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 09:19:41 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:49051 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932300AbVKUOTk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 09:19:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WdvXCcfwExyMs7akon4G66ss7DDPPMhrpAUqNUlF6bq0bUnzdD7zPvPVCV7ivl9CxJVmJyRKap5BM4P26tkqMrtzPM0cwFYw9ukTeobqcObcC9/N3shBhSpqZBrBCZys58m20VOfB6nPx60Gks7lEMVs6wnvY7UIjoYSLEPvcaM=
Message-ID: <9611fa230511210619l208b10a8w77aedaa249345448@mail.gmail.com>
Date: Mon, 21 Nov 2005 14:19:26 +0000
From: Tarkan Erimer <tarkane@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Cc: Diego Calleja <diegocg@gmail.com>
In-Reply-To: <20051121124544.9e502404.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <11b141710511210144h666d2edfi@mail.gmail.com>
	 <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com>
	 <20051121124544.9e502404.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Diego Calleja <diegocg@gmail.com> wrote:
>
> There're some rumors saying that sun might be considering a linux port.
>
> http://www.sun.com/emrkt/campaign_docs/expertexchange/knowledge/solaris_zfs_gen.html#10
>
> Q: Any thoughts on porting ZFS to Linux, AIX, or HPUX?
> A: No plans of porting to AIX and HPUX. Porting to Linux is currently
> being investigated.
>
> (personally I doubt it, that FAQ was written some time ago and Sun's
> executives change their opinion more often than Linus does ;)

If It happenned, Sun or someone has port it to linux.
We will need some VFS changes to handle 128 bit FS as "Jörn ENGEL"
mentionned previous mail in this thread. Is there any plan or action
to make VFS handle 128 bit File Sytems like ZFS or future 128 bit
File Systems ? Any VFS people reply to this, please?

Regards
