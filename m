Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVBCBIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVBCBIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVBCBIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:08:16 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:35855 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262893AbVBCBIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:08:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=m0neiiuy0wjYC6AnEERuAMeR7cS1JwOAY9FE+vwVpeiW85s3wKgsPnVJQcDeVOeeN4M6ov52jz+krAjVqLHyHQ3kcUxWCQKVOfvqjigq9ZLxt3uoLx8Tm20Pzh3Qt/Fqku/0r/zQ2bnRxkg66u7iZsZZoLGRt+KwkpR0pFT9Arg=
Message-ID: <58cb370e05020217075ae130a7@mail.gmail.com>
Date: Thu, 3 Feb 2005 02:07:56 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 13/29] ide: use time_after() macro
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202025649.GN621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202025649.GN621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:56:49 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 13_ide_tape_time_after.patch
> >
> >       Explicit jiffy comparision converted to time_after() macro.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied
