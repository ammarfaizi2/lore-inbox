Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273298AbRINFCR>; Fri, 14 Sep 2001 01:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273300AbRINFCH>; Fri, 14 Sep 2001 01:02:07 -0400
Received: from c009-h018.c009.snv.cp.net ([209.228.34.131]:62689 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S273298AbRINFB6>;
	Fri, 14 Sep 2001 01:01:58 -0400
X-Sent: 14 Sep 2001 05:02:15 GMT
Date: Thu, 13 Sep 2001 22:02:27 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <dri-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <mharris@redhat.com>
Subject: Re: Radeon lockup fix
In-Reply-To: <20010913221834.E29816@redhat.com>
Message-ID: <Pine.LNX.4.33.0109132157010.474-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, Stephen C. Tweedie wrote:

> Hi,
>
> I've also been seeing the AMD-761 + radeon total lockup when X starts,
> as described in
>
> http://sourceforge.net/tracker/index.php?func=detail&aid=221904&group_id=387&atid=100387
>
> The X server fixes from ATI seem to fix this when running without dri,
> but in dri mode, I still see the lockups 75% of the time.  However,
> the fix described above and appended below appears to be a complete
> cure for me so far.

This patch also works fine for my All-in-Wonder Radeon on an AMD 760
mainboard.  Tested with the DRI trunk.

-jwb

