Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTD3IRy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTD3IRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:17:54 -0400
Received: from AMarseille-201-1-4-229.abo.wanadoo.fr ([217.128.74.229]:24359
	"EHLO gaston") by vger.kernel.org with ESMTP id S262136AbTD3IRx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:17:53 -0400
Subject: Re: must-fix list for 2.6.0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030429155731.07811707.akpm@digeo.com>
References: <20030429155731.07811707.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051691400.576.48.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Apr 2003 10:30:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-30 at 00:57, Andrew Morton wrote:

> - IDE suspend/resume without races (Ben is looking at this a little)

I have something that work not too badly for PPC already but that need
some cleanup, to be tested/adapted to Pat's new work (especially tested
against his swsusp, and we shall still verify if it fits x86 needs)


