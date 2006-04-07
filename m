Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932250AbWDGOUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbWDGOUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDGOUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:20:06 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:54632 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932250AbWDGOUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:20:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=B6kVxWAN4tVyNB6wCXQe89d9f6skjNjqX/kVAuauAN9faoZP7YwlQA3cYOjgXROBGoxjg5fuB8lZpllYxjym2Zcfo79IuAgM1Ck10DQoe6R4FZnLwysOdQb/kyVsCer0PhYzSbTtdTRhYbrGmfiAlqMvgngBtJQ9PFcaJHT/Cdc=
Date: Fri, 7 Apr 2006 16:16:45 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Clayton <andrew@rootshell.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [oops] 2.6.17-rc1
Message-ID: <20060407141645.GB9911@silenus.home.res>
References: <1144416008.22650.13.camel@zeus.pccl.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144416008.22650.13.camel@zeus.pccl.info>
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 03:20:08PM +0100, Andrew Clayton wrote:
> Just got the following while watching a .avi with mplayer.
> 
> System is FC4 running on a single proc AMD64 with 1GB RAM.
> 
This as been reported several times, have a look at bug #6329 
It is reported that this patch helps:
http://bugzilla.kernel.org/attachment.cgi?id=7779&action=view

Regards,
Frederik
