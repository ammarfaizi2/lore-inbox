Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262234AbSJFWjg>; Sun, 6 Oct 2002 18:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262235AbSJFWjg>; Sun, 6 Oct 2002 18:39:36 -0400
Received: from vitelus.com ([64.81.243.207]:47631 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S262234AbSJFWjg>;
	Sun, 6 Oct 2002 18:39:36 -0400
Date: Sun, 6 Oct 2002 15:45:11 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021006224511.GC9785@vitelus.com>
References: <20021006220300.GA9785@vitelus.com> <Pine.LNX.4.44L.0210061931460.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0210061931460.22735-100000@imladris.surriel.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 07:33:55PM -0300, Rik van Riel wrote:
> The following command should work:
> 
> 	rsync -rav --delete nl.linux.org::kernel/linux-2.4 linux-2.4

Thanks.
Note that -a implies -r. You also might want -z in there depending how
your availability of bandwidth and CPU cycles compare.
