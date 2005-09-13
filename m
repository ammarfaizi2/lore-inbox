Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbVIMQcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbVIMQcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVIMQcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:32:36 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:63887 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964862AbVIMQcf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:32:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KSaouM4ZhfQlZrMRBfd5AB6OPxSNYNYSkL4mCyMxLGf+V+3xDWGhZfM2xt9ALaYk/rHETMzyMgpBwn0shtIqAhEgzNpPSUNh/ghMrv3PkUBPNTNTu4GyfBCq5d6jSjo/oVGOkK+i05Sh4YMQ66K9ZM1UkDnwhJub3yf60aWnZMo=
Message-ID: <6bffcb0e050913093272dabea2@mail.gmail.com>
Date: Tue, 13 Sep 2005 18:32:31 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Reply-To: michal.k.k.piotrowski@gmail.com
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Pending -stable patches
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050913182736.09b1bfcf.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050913182736.09b1bfcf.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/09/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi all,
> 
> Is there a place where pending -stable patches can be seen?
> 
> Are mails sent to stable@kernel archived somewhere?
> 
> There seems to be a need for this. For example, there's a patch I would
> like to see in 2.6.13.2, but I wouldn't want to report an already known
> problem.
> 
> Thanks,

http://www.kernel.org/git/?p=linux/kernel/git/chrisw/stable-queue.git;a=shortlog

Regards,
Michal Piotrowski
