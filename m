Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSAGRkI>; Mon, 7 Jan 2002 12:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284191AbSAGRjs>; Mon, 7 Jan 2002 12:39:48 -0500
Received: from ns.ithnet.com ([217.64.64.10]:14599 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S284186AbSAGRjr>;
	Mon, 7 Jan 2002 12:39:47 -0500
Date: Mon, 7 Jan 2002 18:39:37 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-Id: <20020107183937.40625026.skraw@ithnet.com>
In-Reply-To: <20020106153854.A10824@earthlink.net>
In-Reply-To: <20020106153854.A10824@earthlink.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002 15:38:54 -0500
rwhron@earthlink.net wrote:

> In the experiment above, it appears the rc2aa2 VM shinks slabs and 
> page/buffer caches in a reasonable way when a process needs a lot
> of memory.

Hello Randy,

can you please try The Same Thing while copying large files around in the
background (lets say 100MB files) and re-comment.

Thanks,
Stephan

