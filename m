Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278402AbRJMUfd>; Sat, 13 Oct 2001 16:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278400AbRJMUfX>; Sat, 13 Oct 2001 16:35:23 -0400
Received: from vitelus.com ([64.81.243.207]:34822 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S278401AbRJMUfG>;
	Sat, 13 Oct 2001 16:35:06 -0400
Date: Sat, 13 Oct 2001 13:35:29 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, CaT <cat@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel size
Message-ID: <20011013133529.A9856@vitelus.com>
In-Reply-To: <m1zo77zh0h.fsf@frodo.biederman.org> <Pine.LNX.3.95.1011004102214.21964A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1011004102214.21964A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 10:24:48AM -0400, Richard B. Johnson wrote:
> Major size differences seem to depend upon the C compiler being
> used.

The -Os option could help a bit too.
