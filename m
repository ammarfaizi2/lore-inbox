Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVBBXyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVBBXyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVBBXp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:45:27 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:65256 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262767AbVBBXns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:43:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n/04RHYdS+D1WO1KABtOgVrH3RPmgqUV3ZMzz6oKFTt0Fj9gJi7a1E0d3+qmbix4WLuAkGoawX00eCl3jz8R7jT6wYi4IQ3woqpbFV5Lh9n+bXyuTn4cN/diWQxB5DzdlNbMv89ZuowUOPO5wLVtvJWZR86iWE2Ov7kHXErLhV8=
Message-ID: <58cb370e05020215431cda8303@mail.gmail.com>
Date: Thu, 3 Feb 2005 00:43:40 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 01/29] ide: remove adma100
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202024353.GB621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024353.GB621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:43:53 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 01_ide_remove_adma100.patch
> >
> >       Removes drivers/ide/pci/adma100.[hc].  The driver isn't
> >       compilable (missing functions) and no Kconfig actually enables
> >       CONFIG_BLK_DEV_ADMA100.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
