Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275193AbTHGH1x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 03:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275200AbTHGH1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 03:27:53 -0400
Received: from angband.namesys.com ([212.16.7.85]:3763 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S275193AbTHGH1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 03:27:52 -0400
Date: Thu, 7 Aug 2003 11:27:51 +0400
From: Oleg Drokin <green@namesys.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs4
Message-ID: <20030807072751.GA23912@namesys.com>
References: <200308070305.51868.vlad@lazarenko.net> <20030806230220.I7752@schatzie.adilger.int> <3F31DFCC.6040504@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F31DFCC.6040504@cornell.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Aug 07, 2003 at 01:12:44AM -0400, Ivan Gyurdiev wrote:

> >Why do people ever want a "converter"?
> That's been discussed before.
> Because people don't have the resources (hard disk space, tape drives, 
> money)  to backup their data, and might still be interested in testing a 
> new filesystem. They might be willing to take a risk with the new fs 
> and converter. Amazing as it may sound, people do that. I am such a 
> tester, and I'd find a converter to be a useful tool. But since the 
> previous discussion on the subject concluded it'd be really hard to 
> impossible to write one, I guess I'll have to settle for new hard drive(s).

This is no longer true.
There is sort of "universal" fs convertor for linux that can convert almost
any fs to almost any other fs.
The only requirement seems to be that both fs types should have read/write support in Linux.
http://tzukanov.narod.ru/convertfs/

Bye,
    Oleg
