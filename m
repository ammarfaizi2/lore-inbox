Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRHFMWz>; Mon, 6 Aug 2001 08:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbRHFMWp>; Mon, 6 Aug 2001 08:22:45 -0400
Received: from weta.f00f.org ([203.167.249.89]:56720 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S268145AbRHFMWZ>;
	Mon, 6 Aug 2001 08:22:25 -0400
Date: Tue, 7 Aug 2001 00:23:20 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: /proc/<n>/maps getting _VERY_ long
Message-ID: <20010807002320.A23937@weta.f00f.org>
In-Reply-To: <9kkr7r$mov$1@cesium.transmeta.com> <E15Tiw1-0000oU-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15Tiw1-0000oU-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 12:52:37PM +0100, Alan Cox wrote:

    That would explain a lot since mprotect currently doesn't seem to do
    merging, and worse it also seems to not be doing rlimit checking right

Err stupid question, but why does it need to do rlimit checking?


  --cw
