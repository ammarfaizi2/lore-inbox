Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWGXSLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWGXSLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWGXSLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:11:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:11964 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932283AbWGXSLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:11:07 -0400
Message-ID: <44C50D38.9010906@garzik.org>
Date: Mon, 24 Jul 2006 14:11:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Guillaume Chazarain <guichaz@yahoo.fr>
CC: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org> <44C4C559.4090101@yahoo.fr>
In-Reply-To: <44C4C559.4090101@yahoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Chazarain wrote:
> Theodore Ts'o wrote:
>> 3) The ext4 code base will continue to mount older ext3 filesystems,
> 
> Everybody seems enthusiastic about this plan so I must have missed 
> something, but
> how will this compatibility prevent the ext4 code from looking like: 'if 
> (ext4) { ... } else { /* ext3 */ ... }'?

It doesn't.  But you can't win them all...

	Jeff



