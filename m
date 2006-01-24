Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWAXQam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWAXQam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 11:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWAXQal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 11:30:41 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:56000 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030368AbWAXQal convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 11:30:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BAvNACBW4RM6vtBT6XArOEgRF7BdHvtluPbxvcDLU1xx/2VQbFaFePtQJoxjjCnXxg/vTY/mDpvpb6MMr9v07Hq85CBOI8LZx2SxhjF1Os7SVnFu+qSo6koqaCZ0Bkj97CC26glbpkAZDTTAIsNS2dhGWSZ4GMV9CS/3KFJ6FTg=
Message-ID: <9e4733910601240830u4e242be9w73797e6b6d5fa367@mail.gmail.com>
Date: Tue, 24 Jan 2006 11:30:40 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
In-Reply-To: <9e4733910601230722k125f0391w74946b7401be85ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
	 <20060122142401.GA24738@SDF.LONESTAR.ORG>
	 <9e4733910601220931x3a21e47dj7dbf834e2f36d31c@mail.gmail.com>
	 <9e4733910601230722k125f0391w74946b7401be85ce@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've filed a kernel bug summarizing the issue:
http://bugzilla.kernel.org/show_bug.cgi?id=5949

The lighttpd author is willing to provide more info if anyone is interested.

--
Jon Smirl
jonsmirl@gmail.com
