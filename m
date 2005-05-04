Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVEDRYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVEDRYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVEDROd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:14:33 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:59121 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261188AbVEDRKf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:10:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ls3iloaC3enB3Ih6swjkwTloBWT32GF/eQV012HphMEhCXDYMUXs+36vp0GDWC8xwHhZuevEri5dSRkwL3WadatDCaxjE8HmzgPzkvehzZiT/A6t6qUpAnUuLl/ZzE/d1p6kvItK/v+06yAEcz4EdU47ZEz4jfb7QBztS7tOyd4=
Message-ID: <9e47339105050410107d9193b2@mail.gmail.com>
Date: Wed, 4 May 2005 13:10:35 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment policy
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> 
> I think the general opinion of posting patches as attachments
> has changed over the last few years.  Mailers have been getting
> a lot better at handling them, even quoting non-message-body
> plain/text attachments in replies.

There is also the problem of things like gmail/yahoo where you can't
control the word wrapping.  The only way to submit patches from those
services is as an plain text attachment. If you try to submit then
in-line and they wrap wrong you will collect a lot of hate mail from
Andrew.

-- 
Jon Smirl
jonsmirl@gmail.com
