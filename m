Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265760AbTFSKfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 06:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265761AbTFSKfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 06:35:45 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:46160 "EHLO
	exchange.Pronto.TV") by vger.kernel.org with ESMTP id S265760AbTFSKfn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 06:35:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] O_DIRECT for ext3 (2.4.21)
Date: Thu, 19 Jun 2003 12:49:41 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
References: <20030615110106.GA8404@karlsbakk.net> <20030617131927.2ac04150.akpm@digeo.com> <1055882819.16608.4.camel@sisko.scot.redhat.com>
In-Reply-To: <1055882819.16608.4.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306191249.41149.roy@karlsbakk.net>
X-OriginalArrivalTime: 19 Jun 2003 10:49:41.0382 (UTC) FILETIME=[7CB1DA60:01C33650]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 June 2003 22:46, Stephen C. Tweedie wrote:
> That's what the -aa patches do, and I've got those queued in my local
> O_DIRECT stuff already.  ext3 will just expose a different a_ops for
> data-journaled files.

is ext3 O_DIRECT support in -aa?
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

