Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318830AbSHIM2w>; Fri, 9 Aug 2002 08:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSHIM2w>; Fri, 9 Aug 2002 08:28:52 -0400
Received: from dsl-213-023-043-103.arcor-ip.net ([213.23.43.103]:65418 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318830AbSHIM2v>;
	Fri, 9 Aug 2002 08:28:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] write_super is not for syncing (take 3)
Date: Fri, 9 Aug 2002 14:34:34 +0200
X-Mailer: KMail [version 1.3.2]
Cc: marcelo@conectiva.com.br
References: <1028568893.1805.270.camel@tiny>
In-Reply-To: <1028568893.1805.270.camel@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17d8yR-0001La-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 August 2002 19:34, Chris Mason wrote:
> 2) adds a commit_super() call to struct super_operations().  This allows
> the journaled filesystems to differentiate between calls from sync() and
> calls from kupdated.

Thankyou.

-- 
Daniel
