Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUENVae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUENVae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUENVae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:30:34 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:46635 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262238AbUENVaa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:30:30 -0400
Date: Fri, 14 May 2004 23:30:12 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: Jan Kara <jack@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Quota fix 1
In-Reply-To: <20040513143947.GP3629@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58LT.0405142327001.7799@lt.wsisiz.edu.pl>
References: <20040513143947.GP3629@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004, Jan Kara wrote:

>   Hello,
> 
>   I'm sending you a patch which fixes the problem with release_dqblk()
> being NULL for old quota format. The patch is against 2.6.6 (+the patch
> you submitted to Linus). Please apply.

Yes, it fixed problem with oopses on 2.6.6.

-- 
*[ £ukasz Tr±biñski ]*
