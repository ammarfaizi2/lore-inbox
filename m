Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264805AbSJOUut>; Tue, 15 Oct 2002 16:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264808AbSJOUut>; Tue, 15 Oct 2002 16:50:49 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:19270 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S264805AbSJOUur>; Tue, 15 Oct 2002 16:50:47 -0400
Date: Tue, 15 Oct 2002 14:04:26 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Mark Haverkamp <markh@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41: lkcd (8/8): dump driver and build files
In-Reply-To: <1034699059.23807.4.camel@markh1.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210151403350.3076-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Oct 2002, Mark Haverkamp wrote:
|>On Thu, 2002-10-10 at 13:48, Matt D. Robinson wrote:
|>Shouldn't the module exit functions in dump_base.c be marked with __exit
|>rather than __init?

Already corrected, thanks. :)  The 2.5.42 patch will have the changes.

--Matt

