Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131257AbRA3QO6>; Tue, 30 Jan 2001 11:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131399AbRA3QOs>; Tue, 30 Jan 2001 11:14:48 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:45813 "HELO
	localdomain") by vger.kernel.org with SMTP id <S131296AbRA3QOd>;
	Tue, 30 Jan 2001 11:14:33 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Tue, 30 Jan 2001 08:15:39 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain; charset=US-ASCII
Cc: "Romain Kang" <romain@kzsu.stanford.edu>, <linux-kernel@vger.kernel.org>,
        <root@chaos.analogic.com>, "Craig I. Hagan" <hagan@cih.com>
To: "Micah Gorrell" <angelcode@myrealbox.com>,
        "Andrey Savochkin" <saw@saw.sw.com.sg>
In-Reply-To: <003001c08acf$7ae475f0$9b2f4189@angelw2k>
In-Reply-To: <003001c08acf$7ae475f0$9b2f4189@angelw2k>
Subject: Re: eepro100 - Linux vs. FreeBSD
MIME-Version: 1.0
Message-Id: <01013008153900.01000@ewok.dev.mycio.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 January 2001 08:14, Micah Gorrell wrote:
> I have been running 2.2 on many machines since its release and have updated
> to the latest version of 2.2 many times.  All of these machines have an
> eepro100 and I never saw a single problem with any of them.  I updated most
> of my machines to 2.4 over the course of a week and within a day of
> updating each of them showed the problem.  This may be pure chance but it
> sounds to me as if it is a difference with the 2.4 kernel.

I had the same problem on my dual PIII with a dual eepro100 NIC.
2.4.1-pre12 solved the problem ( don't ask me why :) ).



- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
