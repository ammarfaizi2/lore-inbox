Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132385AbRCZIUo>; Mon, 26 Mar 2001 03:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRCZIUf>; Mon, 26 Mar 2001 03:20:35 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:62726 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S132385AbRCZIUW>;
	Mon, 26 Mar 2001 03:20:22 -0500
Date: Mon, 26 Mar 2001 10:19:15 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: John Plate <plate@infotek.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.17-RAID: Eating memory
Message-ID: <20010326101915.A10325@se1.cogenit.fr>
In-Reply-To: <20010326000622.C12805@infotek.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010326000622.C12805@infotek.dk>; from plate@infotek.dk on Mon, Mar 26, 2001 at 12:06:22AM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Plate <plate@infotek.dk> écrit :
[do_try_to_free_pages]

Known issue on < 2.2.19pre kernels (do a search for "do_try_to_free_pages"
on the ML archive). It doesn't require RAID btw. Upgrade to 2.2.19prexx, it
performs better.

-- 
Ueimor
