Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132225AbRA2JN7>; Mon, 29 Jan 2001 04:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132372AbRA2JNt>; Mon, 29 Jan 2001 04:13:49 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:26506 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S132225AbRA2JNh>;
	Mon, 29 Jan 2001 04:13:37 -0500
Message-ID: <20010129171318.A15688@saw.sw.com.sg>
Date: Mon, 29 Jan 2001 17:13:18 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Micah Gorrell <angelcode@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 problems in 2.4.0
In-Reply-To: <003401c0870c$3362e390$9b2f4189@angelw2k>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <003401c0870c$3362e390$9b2f4189@angelw2k>; from "Micah Gorrell" on Thu, Jan 25, 2001 at 01:20:03PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 25, 2001 at 01:20:03PM -0700, Micah Gorrell wrote:
> I have doing some testing with kernel 2.4 and I have had constant problems
> with the eepro100 driver.  Under 2.2 it works perfectly but under 2.4 I am
> unable to use more than one card in a server and when I do use one card I
> get errors stating that eth0 reports no recources.  Has anyone else seen
> this kind of problem?

It's a known problem.
I submitted the patch to Linus and the mailing list this weekend.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
